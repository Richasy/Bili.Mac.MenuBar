//
//  RankCompose.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/6.
//

import SwiftUI
import ComposableArchitecture

struct RankState: Equatable {
    var videos: [VideoState]?
    var isLoading: Bool
}

enum RankAction: Equatable {
    case request
    case receiveRankResponse([VideoState]?)
}

struct RankEnviroment {
    var communityProvider: CommunityProviderProtocol = DIFactory.instance.container.resolve(CommunityProviderProtocol.self)!
}

let rankReducer = Reducer<RankState, RankAction, RankEnviroment> { state, action, env in
    switch action {
    case .request:
        state.isLoading = true
        return .task {
            let data = await env.communityProvider.getRankVideoListAsync()
            return .receiveRankResponse(data)
        }
    case let .receiveRankResponse(data):
        state.videos = data
        state.isLoading = false
        return .none
    }
}
