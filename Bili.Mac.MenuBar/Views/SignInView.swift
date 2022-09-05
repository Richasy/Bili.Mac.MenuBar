//
//  SignInView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/2.
//

import SwiftUI
import ComposableArchitecture

struct SignInView: View {
    
    let store: Store<AuthorizeState, AuthorizeAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                AppLogo()
                    .padding([.top], viewStore.logoTopPadding)
                
                if !viewStore.isShowQRCode {
                    Spacer()
                    Button (action: {
                        viewStore.send(AuthorizeAction.showQRCode)
                    }) {
                        Text("扫码登录")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("ButtonBackground"))
                            .cornerRadius(26)
                            .padding(EdgeInsets(top: 0, leading: 40, bottom: 64, trailing: 40))
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.plain)
                    
                } else {
                    SignInQRCode(store: store)
                        .padding([.top], 45)
                    Spacer()
                }
                
                Group {
                    Text("不主动") +
                    Text("更新").foregroundColor(.secondary) +
                    Text("  |  不拒绝") +
                    Text("使用").foregroundColor(.secondary) +
                    Text("  |  不负责") +
                    Text("维护").foregroundColor(.secondary)
                }.padding([.bottom], 24)
            }
        }
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(store: Store(initialState: .init(), reducer: authorizeReducer, environment: .init()))
            .frame(width: 400, height: 600, alignment: .center)
    }
}
