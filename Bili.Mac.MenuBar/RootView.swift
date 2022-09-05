//
//  ContentView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/30.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    
    let store: Store<AuthorizeState, AuthorizeAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                if viewStore.authorizeStatus == .signedOut {
                    SignInView(store: store)
                        .frame(maxWidth:.infinity, maxHeight: .infinity)
                } else if viewStore.authorizeStatus == .loading {
                    HStack(spacing: 8) {
                        ProgressView()
                        Text("正在尝试登录...")
                            .foregroundColor(.secondary)
                    }.frame(maxWidth:.infinity, maxHeight: .infinity)
                } else {
                    SubscribeView()
                    .frame(maxWidth:.infinity, maxHeight: .infinity)
                }
            }.onAppear {
                viewStore.send(AuthorizeAction.signIn)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: Store(initialState: .init(), reducer: authorizeReducer, environment: .init()))
    }
}
