//
//  EpisodeCompose.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/6.
//

import SwiftUI
import ComposableArchitecture

struct EpisodeState: Codable, Equatable, Hashable, Identifiable {
    var id: String
    var cover: String
    var title: String
    var label: String
    var seasonId: String
    var publishTime: String
    var seasonCover: String
    
    static func == (lhs: EpisodeState, rhs: EpisodeState) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

public enum EpisodeAction: Equatable {
    case click
    case copyLink
    case copyCoverLink
}

let episodeReducer = Reducer<EpisodeState, EpisodeAction, Void> { state, action, _ in
    @Environment(\.openURL) var openURL
    switch action {
    case .click:
        let url = "https://www.bilibili.com/bangumi/play/ep\(state.id)"
        openURL(URL(string: url)!)
    case .copyLink:
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString("https://www.bilibili.com/bangumi/play/ep\(state.id)", forType: .string)
    case .copyCoverLink:
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(state.seasonCover, forType: .string)
    }
    
    return .none
}
