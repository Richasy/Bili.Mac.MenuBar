//
//  PopularCompose.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/15.
//

import SwiftUI
import ComposableArchitecture

struct PopularState: Equatable {
    var videos: [VideoState]?
    var isLoading: Bool
}

enum PopularAction: Equatable {
    case request
    case receivePopularResponse([VideoState]?)
}

struct PopularEnviroment {
    var communityProvider: CommunityProviderProtocol = DIFactory.instance.container.resolve(CommunityProviderProtocol.self)!
}

let popularReducer = Reducer<PopularState, PopularAction, PopularEnviroment> { state, action, env in
    switch action {
    case .request:
        state.isLoading = true
        return .task {
            let data = await env.communityProvider.getPopularVideoListAsync()
            return .receivePopularResponse(data)
        }
    case let .receivePopularResponse(data):
        state.videos = data
        state.isLoading = false
        return .none
    }
}
