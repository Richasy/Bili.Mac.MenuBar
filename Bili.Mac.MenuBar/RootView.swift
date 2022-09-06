//
//  ContentView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/30.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                if viewStore.authorize.authorizeStatus != .signedIn {
                    SignInView(store: store.scope(state: \.authorize, action: AppAction.authorize))
                        .frame(maxWidth:.infinity, maxHeight: .infinity)
                } else {
                    
                    if viewStore.currentPage == PageKeys.subscribe {
                        SubscribeView(store: store)
                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                    } else if viewStore.currentPage == PageKeys.rank {
                        RankView(store: store.scope(state: \.rank, action: AppAction.rank))
                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                    }
                    
                    StatusBar(store: store)
                        .frame(maxWidth:.infinity)
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: Store(initialState: .init(), reducer: appReducer, environment: ()))
    }
}
