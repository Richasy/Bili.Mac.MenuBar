//
//  VideoCompose.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/5.
//

import SwiftUI
import ComposableArchitecture

struct VideoState: Codable, Equatable, Hashable, Identifiable {
    var upAvatar: String
    var upName: String
    var upId: String
    var label: String
    var cover: String
    var title: String
    var playCount: Int32
    var danmuCount: Int32
    var id: String
    var videoId: String
    var link: String
    
    static func == (lhs: VideoState, rhs: VideoState) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

public enum VideoAction: Equatable {
    case click
    case copyLink
    case openUpSpace
}

let videoReducer = Reducer<VideoState, VideoAction, Void> { state, action, _ in
    @Environment(\.openURL) var openURL
    switch action {
    case .click:
        openURL(URL(string: state.link)!)
    case .copyLink:
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(state.link, forType: .string)
    case .openUpSpace:
        openURL(URL(string: "https://space.bilibili.com/\(state.upId)")!)
    }
    
    return .none
}
