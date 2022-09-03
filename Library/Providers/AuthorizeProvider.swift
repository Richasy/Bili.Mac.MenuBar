//
//  AuthorizeProvider.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation
import QRCodeGenerator
import SwiftUI

class AuthorizeProvider: AuthorizeProviderProtocol {
    private let md5Toolkit: MD5ToolkitProtocol
    
    private var tokenInfo: TokenInfo? = nil
    private var internalQRAuthCode: String = ""
    private var lastAuthorizeTime: Date? = nil
    private var currentUserId: String = ""
    private let guid: String
    
    init(md5Toolkit: MD5ToolkitProtocol) {
        self.md5Toolkit = md5Toolkit
        
        self.guid = UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()
        authorizeState = .signedOut
        qrCodeState = .notConfirm
        events = EventBus()
    }
    
    var authorizeState: AuthorizeState {
        didSet {
            events.fireEvent(name: EventKeys.authorizeStateChanged.rawValue, param: authorizeState)
        }
    }
    var qrCodeState: QRCodeState {
        didSet {
            events.fireEvent(name: EventKeys.qrcodeStateChanged.rawValue, param: qrCodeState)
        }
    }
    var events: EventBus
    
    func generateAuthorizedQueryStringAsync(queryParameters: Dictionary<String, String>, clienType: RequestClientType, needToken: Bool) async -> String {
        let parameters = await generateAuthorizeQueryDictionaryAsync(queryParameters: queryParameters, clientType: clienType, needToken: needToken)
        var queryList = parameters.map({"\($0.key)=\($0.value)"})
        queryList.sort()
        let query = queryList.joined(separator: "&")
        return query
    }
    
    func generateAuthorizeQueryDictionaryAsync(queryParameters: Dictionary<String, String>, clientType: RequestClientType, needToken: Bool) async -> Dictionary<String, String> {
        var parameters = queryParameters
        parameters[QueryKeys.build.rawValue] = ServiceKeys.buildNumber.rawValue
        if clientType == .ios {
            parameters[QueryKeys.appKey.rawValue] = TokenKeys.iosKey.rawValue
            parameters[QueryKeys.mobileApp.rawValue] = "iphone"
            parameters[QueryKeys.platform.rawValue] = "ios"
            parameters[QueryKeys.timeStamp.rawValue] = String(Int64(Date.now.timeIntervalSince1970))
        } else if clientType == .android {
            parameters[QueryKeys.appKey.rawValue] = TokenKeys.androidKey.rawValue
            parameters[QueryKeys.mobileApp.rawValue] = "android"
            parameters[QueryKeys.platform.rawValue] = "android"
            parameters[QueryKeys.timeStamp.rawValue] = String(Int64(Date.now.timeIntervalSince1970))
        } else if clientType == .web {
            parameters[QueryKeys.appKey.rawValue] = TokenKeys.webKey.rawValue
            parameters[QueryKeys.platform.rawValue] = "web"
            parameters[QueryKeys.timeStamp.rawValue] = String(Int64(Date.now.timeIntervalSince1970 * 1000))
        } else {
            parameters[QueryKeys.appKey.rawValue] = TokenKeys.loginKey.rawValue
            parameters[QueryKeys.timeStamp.rawValue] = String(Int64(Date.now.timeIntervalSince1970 * 1000))
        }
        
        var token: String = ""
        if await isTokenValidAsync(isNetworkVerify: false) {
            token = tokenInfo!.access_token
        } else if needToken {
            token = await getTokenAsync()
        }
        
        if !token.isEmpty {
            parameters[QueryKeys.accessToken.rawValue] = token
        }
        
        let sign = generateSign(queryParameters: parameters)
        parameters[QueryKeys.sign.rawValue] = sign
        return parameters
    }
    
    func getTokenAsync() async -> String {
        do {
            guard let tokenInfo = tokenInfo else {
                retrieveAuthorizeResult()
                return tokenInfo?.access_token ?? ""
            }
            
            let isValid = await isTokenValidAsync(isNetworkVerify: false)
            if isValid {
                authorizeState = .signedIn
                return tokenInfo.access_token
            } else {
                let token = try await internalRefreshTokenAsync()
                if token != nil {
                    saveAuthorizeResult(result: token)
                    return token?.access_token ?? ""
                }
            }
            
        } catch {
            print(error)
            signOut()
        }
        
        return ""
    }
    
    func signOut() {
        authorizeState = .loading
        print("正在退出账户")
        UserDefaults.standard.removeObject(forKey: "AuthResult")
        UserDefaults.standard.removeObject(forKey: "AuthTime")
        
        if tokenInfo != nil {
            tokenInfo = nil
        }
        
        authorizeState = .signedOut
        currentUserId = ""
        var accountProvider = DIFactory.instance.container.resolve(AccountProviderProtocol.self)!
        accountProvider.userId = ""
    }
    
    func loopQRCodeStatusAsync() async {
        do {
            let httpProvider = DIFactory.instance.container.resolve(HttpProviderProtocol.self)!
            let request = await httpProvider.getRequestMessageAsync(method: "POST", url: ApiKeys.qrCodeCheck.rawValue, queryParams: [QueryKeys.authCode.rawValue: internalQRAuthCode, QueryKeys.localId.rawValue: guid], type: .android, needToken: false)
            let result = try await httpProvider.sendAsync(ServerResponse<TokenInfo>.self, request: request)
            guard result.code == 0 else {
                throw ServiceException(code: result.code, message: result.message)
            }
            
            saveAuthorizeResult(result: result.data)
            qrCodeState = .success
            print(qrCodeState)
        } catch let error as ServiceException {
            qrCodeState = QRCodeState.failed
            if(error.code == 86039) {
                qrCodeState = .notConfirm
            } else if (error.code == 86038 || error.code == -3) {
                qrCodeState = .expired
            }
            
            print(qrCodeState)
        } catch {
            print(error)
            return
        }
    }
    
    func getQRCodeImageAsync() async -> String {
        let queryParameters = [QueryKeys.localId.rawValue: guid]
        let httpProvider = DIFactory.instance.container.resolve(HttpProviderProtocol.self)!
        let request = await httpProvider.getRequestMessageAsync(method: "POST", url: ApiKeys.qrCode.rawValue, queryParams: queryParameters, type: .android, needToken: false)
        let response = try? await httpProvider.sendAsync(ServerResponse<QRInfo>.self, request: request)
        
        guard let response = response else {
            return ""
        }
        
        guard let url = response.data?.url else {
            return ""
        }
        
        internalQRAuthCode = response.data?.auth_code ?? ""
        let qr = try! QRCode.encode(text: url, ecl: .medium)
        let svg = qr.toSVGString(border: 2)
        return svg
    }
    
    func isTokenValidAsync(isNetworkVerify: Bool) async -> Bool {
        let isLocalValid = tokenInfo != nil
        && !tokenInfo!.access_token.isEmpty
        && lastAuthorizeTime != nil
        && lastAuthorizeTime!.timeIntervalSinceNow.isEqual(to: Double(tokenInfo!.expires_in))
        
        let result = isLocalValid && isNetworkVerify
            ? await networkVerifyTokenAsync()
            : isLocalValid
        return result
    }
    
    private func generateSign(queryParameters: Dictionary<String, String>) -> String {
        var queryList = queryParameters.map({"\($0.key)=\($0.value)"});
        queryList.sort()
        
        let apiKey = queryParameters[QueryKeys.appKey.rawValue]
        var apiSecret: String
        
        switch apiKey {
        case TokenKeys.iosKey.rawValue:
            apiSecret = TokenKeys.iosSecret.rawValue
        case TokenKeys.androidKey.rawValue:
            apiSecret = TokenKeys.androidSecret.rawValue
        case TokenKeys.webKey.rawValue:
            apiSecret = TokenKeys.webSecret.rawValue
        default:
            apiSecret = TokenKeys.loginSecret.rawValue
        }
        
        let query = queryList.joined(separator: "&")
        let signQuery = query + apiSecret
        let sign = md5Toolkit.getMd5String(signQuery).lowercased()
        return sign
    }
    
    private func internalRefreshTokenAsync() async throws -> TokenInfo? {
        guard let refreshToken = tokenInfo?.refresh_token else {
            return nil
        }
        
        let httpProvider = DIFactory.instance.container.resolve(HttpProviderProtocol.self)!
        let queryParameters = [QueryKeys.accessToken.rawValue: tokenInfo?.access_token ?? "", QueryKeys.refreshToken.rawValue: refreshToken]
        let request = await httpProvider.getRequestMessageAsync(method: "POST", url: ApiKeys.refreshToken.rawValue, queryParams: queryParameters, type: .ios, needToken: false)
        let result = try await httpProvider.sendAsync(ServerResponse<TokenInfo>.self, request: request)
        await ssoInitAsync()
        
        return result.data
    }
    
    private func ssoInitAsync() async {
        let url = ApiKeys.sso.rawValue
        let httpProvider = DIFactory.instance.container.resolve(HttpProviderProtocol.self)!
        let request = await httpProvider.getRequestMessageAsync(method: "GET", url: url, queryParams: Dictionary<String, String>(), type: .ios, needToken: false)
        try? _ = await httpProvider.sendAsync(ServerResponse<Int32>.self, request: request)
    }
    
    private func networkVerifyTokenAsync() async -> Bool {
        guard !(tokenInfo?.access_token.isEmpty ?? false) else {
            return false
        }
        
        let queryParameters = [QueryKeys.accessToken.rawValue: tokenInfo?.access_token ?? ""]
        
        do {
            let httpProvider = DIFactory.instance.container.resolve(HttpProviderProtocol.self)!
            let request = await httpProvider.getRequestMessageAsync(method: "GET", url: ApiKeys.checkToken.rawValue, queryParams: queryParameters, type: .ios, needToken: false)
            try _ = await httpProvider.sendAsync(ServerResponse<Int32>.self, request: request)
            return true
        } catch {
            return false
        }
    }
    
    private func saveAuthorizeResult(result: TokenInfo?) {
        guard let result = result else {
            return
        }
        
        let data = try! JSONEncoder().encode(result)
        let now = Date.now
        let authJson = String(data: data, encoding: .utf8)
        UserDefaults.standard.set(authJson, forKey: "AuthResult")
        UserDefaults.standard.set(now, forKey: "AuthTime")
        
        print("已保存登录凭据")
        currentUserId = String(result.mid)
        lastAuthorizeTime = now
        tokenInfo = result
        authorizeState = .signedIn
        print("已登录")
    }
    
    private func retrieveAuthorizeResult() {
        guard let authJson = UserDefaults.standard.string(forKey: "AuthResult") else {
            print("本地没有登录凭据")
            tokenInfo = nil
            lastAuthorizeTime = Date()
            return
        }
        
        let jsonData = authJson.data(using: .utf8)
        let token = try? JSONDecoder().decode(TokenInfo.self, from: jsonData!)
        
        guard let token = token else {
            return
        }
        
        print("已取回登录凭据")
        let saveTime = UserDefaults.standard.object(forKey: "AuthTime") as? Date
        currentUserId = String(token.mid)
        tokenInfo = token
        print("用户Id: \(token.mid)")
        lastAuthorizeTime = saveTime
        authorizeState = .signedIn
    }
}
