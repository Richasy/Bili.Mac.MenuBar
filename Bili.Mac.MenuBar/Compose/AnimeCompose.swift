//
//  AnimeCompose.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/6.
//

import SwiftUI
import ComposableArchitecture

struct AnimeState: Equatable {
    var episodes: [EpisodeState]?
    var isLoading: Bool
}

enum AnimeAction {
    case request
    case receiveAnimeResponse([EpisodeState]?)
}

struct AnimeEnviroment {
    var communityProvider: CommunityProviderProtocol = DIFactory.instance.container.resolve(CommunityProviderProtocol.self)!
}

let animeReducer = Reducer<AnimeState, AnimeAction, AnimeEnviroment> { state, action, env in
    switch action {
    case .request:
        state.isLoading = true
        return .task {
            let data = await env.communityProvider.getTodayAnimeAsync()
            return .receiveAnimeResponse(data)
        }
    case let .receiveAnimeResponse(data):
        state.episodes = data
        state.isLoading = false
        return .none
    }
}
