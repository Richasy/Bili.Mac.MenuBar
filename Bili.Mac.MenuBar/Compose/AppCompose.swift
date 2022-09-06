//
//  AppCompose.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/6.
//

import Foundation
import ComposableArchitecture

struct AppState: Equatable {
    
    init() {
        autoRefresh = UserDefaults.standard.bool(forKey: SettingKeys.autoRefresh.rawValue)
    }
    
    @BindableState var autoRefresh: Bool {
        didSet {
            UserDefaults.standard.set(autoRefresh, forKey: SettingKeys.autoRefresh.rawValue)
        }
    }
    
    var authorize: AuthorizeState = .init()
    var account: AccountState = .init()
    var dynamic: DynamicState = .init(isLoading: false)
}

enum AppAction: BindableAction {
    case exit
    case refresh
    case signOut
    case setAutoRefresh(Bool)
    case authorize(AuthorizeAction)
    case account(AccountAction)
    case dynamic(DynamicAction)
    case binding(BindingAction<AppState>)
}

let appReducer = Reducer<AppState, AppAction, Void>.combine(
    authorizeReducer.pullback(
        state: \.authorize,
        action: /AppAction.authorize,
        environment: { _ in .init() }
        ),
    accountReducer.pullback(
        state: \.account,
        action: /AppAction.account,
        environment: { _ in .init()}),
    dynamicReducer.pullback(
        state: \.dynamic,
        action: /AppAction.dynamic,
        environment: { _ in .init()}),
    .init { state, action, _ in
        switch action {
        case .exit:
            exit(0)
        case .refresh:
            if state.authorize.authorizeStatus != .signedIn {
                return .none
            }
            
            return Effect(value: AppAction.account(AccountAction.request))
                .merge(with: Effect(value: AppAction.dynamic(DynamicAction.request)))
        case .signOut:
            return Effect(value: AppAction.authorize(AuthorizeAction.signOut))
        case let .setAutoRefresh(auto):
            state.autoRefresh = auto
            UserDefaults.standard.set(auto, forKey: SettingKeys.autoRefresh.rawValue)
        default:
            return .none
        }
        
        return .none
    }
        .binding()
)
