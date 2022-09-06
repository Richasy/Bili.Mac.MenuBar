//
//  AccountView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/3.
//

import SwiftUI
import ComposableArchitecture

struct SubscribeView: View {
    
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(alignment:.leading) {
                AccountView(store: store.scope(state: \.account, action: AppAction.account))
                    .frame(maxWidth: .infinity, maxHeight: 150, alignment: .top)
                DynamicView(store: store.scope(state: \.dynamic, action: AppAction.dynamic))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

struct SubscribeView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeView(store: Store(initialState: .init(), reducer: appReducer, environment: ()))
            .frame(width: 400, height: 600, alignment: .center)
    }
}
