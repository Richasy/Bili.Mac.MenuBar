//
//  AuthorizeProvider.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation
import QRCodeGenerator
import SwiftEventBus

class AuthorizeProvider: AuthorizeProviderProtocol {
    private let md5Toolkit: MD5ToolkitProtocol
    private let settingsToolkit: SettingsToolkitProtocol
    
    private var tokenInfo: TokenInfo? = nil
    private var internalQRAuthCode: String = ""
    private var lastAuthorizeTime: Date? = nil
    private var currentUserId: String = ""
    private let guid: String
    
    init(md5Toolkit: MD5ToolkitProtocol, settingsToolkit: SettingsToolkitProtocol) {
        self.md5Toolkit = md5Toolkit
        self.settingsToolkit = settingsToolkit
        
        self.guid = UUID().uuidString
        state = .signedOut
    }
    
    var state: AuthorizeState {
        didSet {
            if oldValue != state {
                let args = AuthorizeStateChangedEventArgs(oldState: oldValue, newState: state)
                SwiftEventBus.post(EventKeys.authorizeStateChanged.rawValue, sender: args)
            }
        }
    }
    
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
            parameters[QueryKeys.timeStamp.rawValue] = String(Date.now.timeIntervalSince1970.rounded())
        } else if clientType == .android {
            parameters[QueryKeys.appKey.rawValue] = TokenKeys.androidKey.rawValue
            parameters[QueryKeys.mobileApp.rawValue] = "android"
            parameters[QueryKeys.platform.rawValue] = "android"
            parameters[QueryKeys.timeStamp.rawValue] = String(Date.now.timeIntervalSince1970.rounded())
        } else if clientType == .web {
            parameters[QueryKeys.appKey.rawValue] = TokenKeys.webKey.rawValue
            parameters[QueryKeys.platform.rawValue] = "web"
            parameters[QueryKeys.timeStamp.rawValue] = String(Date.now.timeIntervalSince1970.rounded() * 1000)
        } else {
            parameters[QueryKeys.appKey.rawValue] = TokenKeys.loginKey.rawValue
            parameters[QueryKeys.timeStamp.rawValue] = String(Date.now.timeIntervalSince1970.rounded() * 1000)
        }
        
        var token: String = ""
        if await isTokenValidAsync(isNetworkVerify: false) {
            token = tokenInfo!.acessToken
        } else if needToken {
            token = await getTokenAsync()
        }
        
        if !token.isEmpty {
            parameters[QueryKeys.accessToken.rawValue] = token
        } else if needToken {
            return parameters
        }
        
        let sign = generateSign(queryParameters: parameters)
        parameters[QueryKeys.sign.rawValue] = sign
        return parameters
    }
    
    func getTokenAsync() async -> String {
        do {
            guard let tokenInfo = tokenInfo else {
                retrieveAuthorizeResult()
                return tokenInfo?.acessToken ?? ""
            }
            
            let isValid = await isTokenValidAsync(isNetworkVerify: false)
            if isValid {
                state = .signedIn
                return tokenInfo.acessToken
            } else {
                let token = try await internalRefreshTokenAsync()
                if token != nil {
                    saveAuthorizeResult(result: token)
                    return token?.acessToken ?? ""
                }
            }
            
        } catch {
            signOut()
        }
        
        return ""
    }
    
    func signOut() {
        state = .loading
        
        settingsToolkit.deleteLocalSetting(settingName: "AuthResult")
        settingsToolkit.deleteLocalSetting(settingName: "AuthTime")
        
        if tokenInfo != nil {
            tokenInfo = nil
        }
        
        state = .signedOut
        currentUserId = ""
        var accountProvider = DIFactory.instance.container.resolve(AccountProviderProtocol.self)!
        accountProvider.userId = ""
    }
    
    func loopQRCodeStatusAsync() async {
        do {
            let httpProvider = DIFactory.instance.container.resolve(HttpProviderProtocol.self)!
            let request = await httpProvider.getRequestMessageAsync(method: "POST", url: ApiKeys.qrCodeCheck.rawValue, queryParams: [QueryKeys.authCode.rawValue: internalQRAuthCode, QueryKeys.localId.rawValue: guid], type: .ios, needToken: false)
            let result = try await httpProvider.sendAsync(ServerResponse<TokenInfo>.self, request: request)
            let arg = QRCodeStateChangedEventArgs(state: .success, token: result.data)
            SwiftEventBus.post(EventKeys.qrcodeStateChanged.rawValue, sender: arg)
        } catch let error as ServiceException {
            var qrStatus = QRCodeState.failed
            if(error.code == 86039) {
                qrStatus = .notConfirm
            } else if (error.code == 86038 || error.code == -3) {
                qrStatus = .expired
            }
            
            let arg = QRCodeStateChangedEventArgs(state: qrStatus, token: nil)
            SwiftEventBus.post(EventKeys.qrcodeStateChanged.rawValue, sender: arg)
        } catch {
            return
        }
    }
    
    func getQRCodeImageAsync() async -> String {
        let queryParameters = [QueryKeys.localId.rawValue: guid]
        let httpProvider = DIFactory.instance.container.resolve(HttpProviderProtocol.self)!
        let request = await httpProvider.getRequestMessageAsync(method: "POST", url: ApiKeys.qrCode.rawValue, queryParams: queryParameters, type: .ios, needToken: false)
        let response = try? await httpProvider.sendAsync(ServerResponse<QRInfo>.self, request: request)
        
        guard let response = response else {
            return ""
        }
        
        let qr = try! QRCode.encode(text: response.data.url, ecl: .medium)
        let svg = qr.toSVGString(border: 2)
        return svg
    }
    
    func isTokenValidAsync(isNetworkVerify: Bool) async -> Bool {
        let isLocalValid = tokenInfo != nil
        && !tokenInfo!.acessToken.isEmpty
        && lastAuthorizeTime != nil
        && lastAuthorizeTime!.timeIntervalSinceNow.isEqual(to: Double(tokenInfo!.expiresIn))
        
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
        guard let refreshToken = tokenInfo?.refreshToken else {
            return nil
        }
        
        let httpProvider = DIFactory.instance.container.resolve(HttpProviderProtocol.self)!
        let queryParameters = [QueryKeys.accessToken.rawValue: tokenInfo?.acessToken ?? "", QueryKeys.refreshToken.rawValue: refreshToken]
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
        guard !(tokenInfo?.acessToken.isEmpty ?? false) else {
            return false
        }
        
        let queryParameters = [QueryKeys.accessToken.rawValue: tokenInfo?.acessToken ?? ""]
        
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
        let json = String(data: data, encoding: .utf8)
        let now = Date.now
        settingsToolkit.writeLocalSetting(settingName: "AuthResult", value: json)
        settingsToolkit.writeLocalSetting(settingName: "AuthTime", value: now.timeIntervalSince1970)
        
        currentUserId = String(result.mid)
        lastAuthorizeTime = now
        tokenInfo = result
        state = .signedIn
    }
    
    private func retrieveAuthorizeResult() {
        guard settingsToolkit.isSettingKeyExist(settingName: "AuthResult") else {
            tokenInfo = nil
            lastAuthorizeTime = Date()
            return
        }
        
        let tokenJson = settingsToolkit.readLocalSetting(settingName: "AuthResult", defaultValue: "{}")
        let tokenData = tokenJson?.data(using: .utf8)
        let token = try? JSONDecoder().decode(TokenInfo.self, from: tokenData!)
        
        guard let token = token else {
            return
        }
        
        let saveTime = settingsToolkit.readLocalSetting(settingName: "AuthTime", defaultValue: TimeInterval(0))
        currentUserId = String(token.mid)
        tokenInfo = token
        lastAuthorizeTime = Date.init(timeIntervalSince1970: saveTime!)
        state = .signedIn
    }
}
