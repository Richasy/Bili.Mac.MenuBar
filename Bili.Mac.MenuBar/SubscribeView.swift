//
//  AccountView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/3.
//

import SwiftUI
import ComposableArchitecture

struct SubscribeView: View {
    
    var body: some View {
        VStack(alignment:.leading) {
            AccountView(store: Store(
                initialState: .init(),
                reducer: accountReducer,
                environment: .init(accountProvider: DIFactory.instance.container.resolve(AccountProviderProtocol.self)!)))
                .frame(maxWidth: .infinity, maxHeight: 150, alignment: .top)
            DynamicView(store: Store(
                initialState: .init(isLoading: false),
                reducer: dynamicReducer,
                environment: .init(communityProvider: DIFactory.instance.container.resolve(CommunityProviderProtocol.self)!)))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct SubscribeView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeView()
            .frame(width: 400, height: 600, alignment: .center)
    }
}
