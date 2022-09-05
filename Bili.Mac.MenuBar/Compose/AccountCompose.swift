//
//  AccountCompose.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/5.
//

import ComposableArchitecture
import SwiftUI

struct AccountState: Equatable {
    var avatar: URL? = nil
    var userName: String = "--"
    var level: Int16 = 0
    var coinNumber: Double = 0.0
    var bcoinNumber: Double = 0.0
    var userId: String = ""
    @BindableState var followingNumber: Int32 = 0
    @BindableState var fansNumber: Int32 = 0
    @BindableState var dynamicNumber: Int32 = 0
    @BindableState var messageNumber: Int32 = 0
    @BindableState var followingLink: String = ""
    @BindableState var fansLink: String = ""
    @BindableState var dynamicLink: String = ""
    @BindableState var messageLink: String = "https://message.bilibili.com/"
}

enum AccountAction: BindableAction {
    case request
    case openSpace
    case receiveAccountResponse(Mine?, UnreadInfo?)
    case binding(BindingAction<AccountState>)
}

struct AccountEnviroment {
    var accountProvider: AccountProviderProtocol
}

let accountReducer = Reducer<AccountState, AccountAction, AccountEnviroment> { state, action, env in
    @Environment(\.openURL) var openURL
    switch action {
    case .request:
        return .task {
            let info = await env.accountProvider.getMyInformationAsync()
            let unreadMsg = await env.accountProvider.getUnreadMessageAsync()
            return .receiveAccountResponse(info, unreadMsg)
        }
    case .openSpace:
        openURL(URL(string: "https://space.bilibili.com/\(state.userId)")!)
        return .none
    case let .receiveAccountResponse(mine, unread):
        mine!.assignAccountState(state: &state, unreadCount: unread!.total())
        return .none
    case .binding:
        return .none
    }
}
.binding()
