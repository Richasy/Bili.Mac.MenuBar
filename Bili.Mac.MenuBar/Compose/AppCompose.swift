//
//  AppCompose.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/6.
//

import SwiftUI
import ComposableArchitecture

struct AppState: Equatable {
    
    init() {
        autoRefresh = UserDefaults.standard.bool(forKey: SettingKeys.autoRefresh.rawValue)
        currentPage = PageKeys(rawValue: UserDefaults.standard.integer(forKey: SettingKeys.currentPage.rawValue)) ?? .subscribe
    }
    
    @BindableState var autoRefresh: Bool
    @BindableState var currentPage: PageKeys
    var hasUpdate: Bool = false
    
    var authorize: AuthorizeState = .init()
    var account: AccountState = .init()
    var dynamic: DynamicState = .init(isLoading: false)
    var rank: RankState = .init(isLoading: false)
    var anime: AnimeState = .init(isLoading: false)
    var hotSearch: HotSearchState = .init(isLoading: false)
}

enum AppAction: BindableAction {
    case exit
    case refresh
    case signOut
    case saveAutoRefresh
    case saveCurrentPage
    case checkUpdate
    case receiveCheckUpdateResult(Bool?)
    case openRelease
    case authorize(AuthorizeAction)
    case account(AccountAction)
    case dynamic(DynamicAction)
    case rank(RankAction)
    case anime(AnimeAction)
    case hotSearch(HotSearchAction)
    case binding(BindingAction<AppState>)
}

struct AppEnviroment {
    var updateProvider = DIFactory.instance.container.resolve(UpdateProviderProtocol.self)!
}

let appReducer = Reducer<AppState, AppAction, AppEnviroment>.combine(
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
    animeReducer.pullback(
        state: \.anime,
        action: /AppAction.anime,
        environment: { _ in .init() }),
    hotSearchReducer.pullback(
        state: \.hotSearch,
        action: /AppAction.hotSearch,
        environment: { _ in .init()}),
    .init { state, action, env in
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
            } else if state.currentPage == PageKeys.todayAnime {
                return Effect(value: AppAction.anime(AnimeAction.request))
            } else if state.currentPage == PageKeys.hotSearch {
                return Effect(value: AppAction.hotSearch(HotSearchAction.request))
            }
            
        case .signOut:
            return Effect(value: AppAction.authorize(AuthorizeAction.signOut))
        case .saveAutoRefresh:
            UserDefaults.standard.set(state.autoRefresh, forKey: SettingKeys.autoRefresh.rawValue)
        case .saveCurrentPage:
            UserDefaults.standard.set(state.currentPage.rawValue, forKey: SettingKeys.currentPage.rawValue)
        case .checkUpdate:
            return .task {
                var hasUpdate = await env.updateProvider.hasUpdateAsync()
                return .receiveCheckUpdateResult(hasUpdate)
            }
        case let .receiveCheckUpdateResult(result):
            guard let result = result else {
                break
            }
            state.hasUpdate = result
        case .openRelease:
            @Environment(\.openURL) var openURL;
            openURL(URL(string: "https://github.com/Richasy/Bili.Mac.MenuBar/releases")!)
        default:
            break
        }
        
        return .none
    }
        .binding()
)
