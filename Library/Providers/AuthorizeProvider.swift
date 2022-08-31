//
//  AuthorizeProvider.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

class AuthorizeProvider: AuthorizeProviderProtocol {
    private let md5Toolkit: MD5ToolkitProtocol
    private let settingsToolkit: SettingsToolkitProtocol
    
    private var tokenInfo: TokenInfo
    private var internalQRAuthCode: String
    
    init(md5Toolkit: MD5ToolkitProtocol, settingsToolkit: SettingsToolkitProtocol) {
        self.md5Toolkit = md5Toolkit
        self.settingsToolkit = settingsToolkit
        
        self.authorizeStateChangedNotifyList = Set<Event<AuthorizeStateChangedEventArgs>>()
        self.qrCodeStateChangedNotifyList = Set<Event<QRCodeStateChangedEventArgs>>()
        state = .signedOut
    }
    
    var authorizeStateChangedNotifyList: Set<Event<AuthorizeStateChangedEventArgs>>
    
    var qrCodeStateChangedNotifyList: Set<Event<QRCodeStateChangedEventArgs>>
    
    var state: AuthorizeState {
        didSet {
            if oldValue != state {
                for event in authorizeStateChangedNotifyList {
                    let args = AuthorizeStateChangedEventArgs(oldState: oldValue, newState: state)
                    event.event(args)
                }
            }
        }
    }
    
    func generateAuthorizedQueryStringAsync(queryParameters: Dictionary<String, String>, clienType: RequestClientType, needToken: Bool) -> String {
        let parameters = generateAuthorizeQueryDictionary(queryParameters: queryParameters, clientType: clienType, needToken: needToken)
        var queryList = parameters.map({"\($0.key)=\($0.value)"})
        queryList.sort()
        let query = queryList.joined(separator: "&")
        return query
    }
    
    func generateAuthorizeQueryDictionary(queryParameters: Dictionary<String, String>, clientType: RequestClientType, needToken: Bool) -> Dictionary<String, String> {
        var parameters = queryParameters
        parameters[QueryKeys.build.rawValue] = ServiceKeys.buildNumber.rawValue
        if clientType == .ios {
            parameters[QueryKeys.appKey.rawValue] = TokenKeys.iosKey.rawValue
            parameters[QueryKeys.mobileApp.rawValue] = "iphone"
            parameters[QueryKeys.platform.rawValue] = "ios"
            parameters[QueryKeys.timeStamp.rawValue] = String(Date.now.timeIntervalSince1970)
        } else if clientType == .android {
            parameters[QueryKeys.appKey.rawValue] = TokenKeys.androidKey.rawValue
            parameters[QueryKeys.mobileApp.rawValue] = "android"
            parameters[QueryKeys.platform.rawValue] = "android"
            parameters[QueryKeys.timeStamp.rawValue] = String(Date.now.timeIntervalSince1970)
        } else if clientType == .web {
            parameters[QueryKeys.appKey.rawValue] = TokenKeys.webKey.rawValue
            parameters[QueryKeys.platform.rawValue] = "web"
            parameters[QueryKeys.timeStamp.rawValue] = String(Date.now.timeIntervalSince1970 * 1000)
        } else {
            parameters[QueryKeys.appKey.rawValue] = TokenKeys.loginKey.rawValue
            parameters[QueryKeys.timeStamp.rawValue] = String(Date.now.timeIntervalSince1970 * 1000)
        }
        
        var token: String
        if isTokenValid(isNetworkVerify: false) {
            token = tokenInfo.acessToken
        } else if needToken {
            token = getToken()
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
    
    func getToken() -> String {
        <#code#>
    }
    
    func trySignIn() -> Bool {
        <#code#>
    }
    
    func signOut() {
        <#code#>
    }
    
    func isTokenValid(isNetworkVerify: Bool) -> Bool {
        <#code#>
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
}
