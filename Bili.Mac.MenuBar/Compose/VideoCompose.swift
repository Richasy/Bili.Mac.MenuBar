//
//  VideoCompose.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/5.
//

import SwiftUI
import ComposableArchitecture

struct VideoState: Codable, Equatable, Hashable, Identifiable {
    
    init(
        upAvatar: String,
        upName: String,
        upId: String,
        label: String,
        cover: String,
        title: String,
        playCount: Int32,
        danmuCount: Int32,
        id: String,
        videoId: String,
        link: String,
        duration: String = "") {
            self.upAvatar = upAvatar
            self.upName = upName
            self.upId = upId
            self.label = label
            self.cover = cover
            self.title = title
            self.playCount = playCount
            self.danmuCount = danmuCount
            self.id = id
            self.videoId = videoId
            self.link = link
            self.duration = duration
            self.isShowUp = !self.upAvatar.isEmpty
            self.isShowDanmu = self.danmuCount != -1
            self.isShowDuration = !self.duration.isEmpty
    }
    
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
    var duration: String
    var isShowUp = true
    var isShowDanmu = true
    var isShowDuration = false
    
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
        // openURL(URL(string: state.link)!)
        UserDefaults.standard.set(state.link, forKey: "TempUrl")
        NSApp.sendAction(#selector(AppDelegate.openPlayerWindow), to: nil, from:nil)
    case .copyLink:
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(state.link, forType: .string)
    case .openUpSpace:
        openURL(URL(string: "https://space.bilibili.com/\(state.upId)")!)
    }
    
    return .none
}
