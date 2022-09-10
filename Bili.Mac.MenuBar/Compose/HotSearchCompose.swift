//
//  HotSearchCompose.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/9.
//

import SwiftUI
import ComposableArchitecture

struct HotSearchState: Equatable {
    var list: [HotSearchItemState]?
    var isLoading: Bool
}

enum HotSearchAction: Equatable {
    case request
    case receiveHotSearchResponse([HotSearchItemState]?)
}

struct HotSearchEnviroment {
    var communityProvider: CommunityProviderProtocol = DIFactory.instance.container.resolve(CommunityProviderProtocol.self)!
}

let hotSearchReducer = Reducer<HotSearchState, HotSearchAction, HotSearchEnviroment> { state, action, env in
    switch action {
    case .request:
        state.isLoading = true
        return .task {
            let data = await env.communityProvider.getHotSearchAsync()
            return .receiveHotSearchResponse(data)
        }
    case let .receiveHotSearchResponse(data):
        state.list = data
        state.isLoading = false
        return .none
    }
}
