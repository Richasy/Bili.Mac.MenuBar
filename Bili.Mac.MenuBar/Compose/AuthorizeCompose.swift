//
//  AuthorizeCompose.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/5.
//

import ComposableArchitecture
import SwiftUI

struct AuthorizeState: Equatable {
    var qrCodeStatus: QRCodeStatus = .notConfirm
    var authorizeStatus: AuthorizeStatus = .signedOut
    var isShowQRCode: Bool = false
    var logoTopPadding: Double = 100
    @BindableState var qrCodePath: URL? = nil
    @BindableState var isQRCodeFailed: Bool = false
    @BindableState var isQRCodeLoading: Bool = false
}

enum AuthorizeAction: BindableAction {
    case signIn
    case signOut
    case showQRCode
    case requestQRCode
    case checkQRCode
    case clearQRCode
    case receiveSignInResponse(Bool)
    case receiveQRCodeResponse(URL?)
    case receiveQRCodeCheckResult(QRCodeStatus)
    case binding(BindingAction<AuthorizeState>)
}

struct AuthorizeEnviroment {
    var authorizeProvider: AuthorizeProviderProtocol = DIFactory.instance.container.resolve(AuthorizeProviderProtocol.self)!
}

let authorizeReducer = Reducer<AuthorizeState, AuthorizeAction, AuthorizeEnviroment> { state, action, env in
    switch action {
    case .signIn:
        state.authorizeStatus = .loading
        return .task {
            let isValid = await env.authorizeProvider.trySignInAsync()
            return .receiveSignInResponse(isValid)
        }
    case .signOut:
        state.authorizeStatus = .signedOut
        env.authorizeProvider.signOut()
    case .showQRCode:
        state.isShowQRCode = true
        state.logoTopPadding = 46
    case .requestQRCode:
        state.isQRCodeLoading = true
        return .task {
            let qrImage = await env.authorizeProvider.getQRCodeImageAsync()
            guard !qrImage.isEmpty else {
                return .receiveQRCodeResponse(nil)
            }
            
            var url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            url.appendPathComponent("bili_signin_qrcode.svg")
            if let data = qrImage.data(using: .utf8) {
                try? data.write(to: url)
                return .receiveQRCodeResponse(url)
            }
            
            return .receiveQRCodeResponse(nil)
        }
    case .checkQRCode:
        return .task {
            let status = await env.authorizeProvider.loopQRCodeStatusAsync()
            return .receiveQRCodeCheckResult(status)
        }
    case .clearQRCode:
        guard let path = state.qrCodePath else {
            return .none
        }
        
        try? FileManager.default.removeItem(atPath: path.path)
        state.qrCodePath = nil
    case let .receiveQRCodeResponse(url):
        state.isQRCodeLoading = false
        state.isQRCodeFailed = url == nil
        state.qrCodePath = url
    case let .receiveQRCodeCheckResult(status):
        state.qrCodeStatus = status
        if status == .success {
            state.authorizeStatus = .signedIn
        }
    case let .receiveSignInResponse(isValid):
        state.authorizeStatus = isValid ? .signedIn: .signedOut
    case .binding:
        return .none
    }
    
    return .none
}
    .binding()
