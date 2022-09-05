//
//  DynamicCompose.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/5.
//

import ComposableArchitecture
import SwiftUI

struct DynamicState: Equatable {
    var videos: [VideoState]?
    var isLoading: Bool
}

enum DynamicAction: Equatable {
    case request
    case receiveDynamicResponse([VideoState]?)
}

struct DynamicEnviroment {
    var communityProvider: CommunityProviderProtocol
}

let dynamicReducer = Reducer<DynamicState, DynamicAction, DynamicEnviroment> { state, action, env in
    switch action {
    case .request:
        state.isLoading = true
        return .task {
            let data = await env.communityProvider.getDynamicVideoListAsync()
            return .receiveDynamicResponse(data)
        }
    case let .receiveDynamicResponse(data):
        state.videos = data
        state.isLoading = false
        return .none
    }
}
