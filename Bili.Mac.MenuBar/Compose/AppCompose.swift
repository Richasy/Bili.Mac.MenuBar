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
        currentPage = PageKeys(rawValue: UserDefaults.standard.integer(forKey: SettingKeys.currentPage.rawValue)) ?? .subscribe
    }
    
    @BindableState var autoRefresh: Bool
    @BindableState var currentPage: PageKeys
    
    var authorize: AuthorizeState = .init()
    var account: AccountState = .init()
    var dynamic: DynamicState = .init(isLoading: false)
    var rank: RankState = .init(isLoading: false)
}

enum AppAction: BindableAction {
    case exit
    case refresh
    case signOut
    case saveAutoRefresh
    case saveCurrentPage
    case authorize(AuthorizeAction)
    case account(AccountAction)
    case dynamic(DynamicAction)
    case rank(RankAction)
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
    rankReducer.pullback(
        state: \.rank,
        action: /AppAction.rank,
        environment: { _ in .init() }),
    .init { state, action, _ in
        switch action {
        case .exit:
            exit(0)
        case .refresh:
            if state.authorize.authorizeStatus != .signedIn {
                return .none
            }
            
            if state.currentPage == PageKeys.subscribe {
                return Effect(value: AppAction.account(AccountAction.request))
                    .merge(with: Effect(value: AppAction.dynamic(DynamicAction.request)))
            } else if state.currentPage == PageKeys.rank {
                return Effect(value: AppAction.rank(RankAction.request))
            }
            
        case .signOut:
            return Effect(value: AppAction.authorize(AuthorizeAction.signOut))
        case .saveAutoRefresh:
            UserDefaults.standard.set(state.autoRefresh, forKey: SettingKeys.autoRefresh.rawValue)
        case .saveCurrentPage:
            UserDefaults.standard.set(state.currentPage.rawValue, forKey: SettingKeys.currentPage.rawValue)
        default:
            return .none
        }
        
        return .none
    }
        .binding()
)
