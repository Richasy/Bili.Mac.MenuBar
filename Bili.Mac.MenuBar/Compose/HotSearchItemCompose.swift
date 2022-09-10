//
//  HotSearchItemCompose.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/9.
//

import SwiftUI
import ComposableArchitecture

struct HotSearchItemState: Equatable, Identifiable {
    var title: String
    var icon: String
    var isShowIcon: Bool
    var id: String
    var keyword: String
}

enum HotSearchItemAction {
    case open
}

let hotSearchItemReducer = Reducer<HotSearchItemState, HotSearchItemAction, Void> { state, action, _ in
    @Environment(\.openURL) var openURL
    switch action {
    case .open:
        let url = "https://search.bilibili.com/all?keyword=\(state.keyword)"
        openURL(URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!)
    }
    
    return .none
}
