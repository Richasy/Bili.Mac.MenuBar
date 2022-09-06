//
//  SignInQRCode.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/2.
//

import SwiftUI
import SVGView
import ComposableArchitecture

struct SignInQRCode: View {
    
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    let store: Store<AuthorizeState, AuthorizeAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                if viewStore.isQRCodeLoading {
                    HStack(spacing: 8) {
                        ProgressView()
                        Text("加载中...")
                            .foregroundColor(.secondary)
                    }
                } else if viewStore.isQRCodeFailed {
                    Text("获取二维码失败，请稍后重试")
                        .foregroundColor(.secondary)
                    Button(action: {
                        viewStore.send(AuthorizeAction.requestQRCode)
                    }) {
                        Text("刷新二维码")
                    }
                    .buttonStyle(.link)
                    .padding([.top], 10)
                } else if viewStore.qrCodePath != nil {
                    SVGView(contentsOf: viewStore.qrCodePath!)
                        .frame(width: 240, height: 240, alignment: .center)
                        .onReceive(timer) { input in
                            viewStore.send(AuthorizeAction.checkQRCode)
                        }
                    
                    Text("请使用移动客户端扫码登录")
                        .foregroundColor(.secondary)
                        .padding([.top], 16)
                    
                    if viewStore.qrCodeStatus != .success {
                        Button(action: {
                            viewStore.send(AuthorizeAction.requestQRCode)
                        }) {
                            Text("刷新二维码")
                        }
                        .buttonStyle(.link)
                        .padding([.top], 12)
                    }
                }
            }.onAppear {
                viewStore.send(AuthorizeAction.requestQRCode)
            }.onDisappear {
                viewStore.send(AuthorizeAction.clearQRCode)
                timer.upstream.connect().cancel()
            }
        }
    }
}

struct SignInQRCode_Previews: PreviewProvider {
    static var previews: some View {
        SignInQRCode(store: Store(initialState: .init(), reducer: authorizeReducer, environment: .init()))
            .frame(width: 200, height: 260, alignment: .center)
    }
}
