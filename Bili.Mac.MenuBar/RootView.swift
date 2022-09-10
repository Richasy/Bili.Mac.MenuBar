//
//  ContentView.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/8/30.
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
                    } else if viewStore.currentPage == PageKeys.todayAnime {
                        AnimeView(store: store.scope(state: \.anime, action: AppAction.anime))
                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                    } else if viewStore.currentPage == PageKeys.hotSearch {
                        HotSearchView(store: store.scope(state: \.hotSearch, action: AppAction.hotSearch))
                            .frame(maxWidth:.infinity, maxHeight: .infinity)
                    }
                    
                    StatusBar(store: store)
                        .frame(maxWidth:.infinity)
                        .onAppear {
                            viewStore.send(.checkUpdate)
                        }
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: Store(initialState: .init(), reducer: appReducer, environment: .init()))
            .frame(width: 400, height: 600, alignment: .center)
    }
}
