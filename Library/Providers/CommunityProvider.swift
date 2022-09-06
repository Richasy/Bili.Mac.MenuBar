//
//  CommunityProvider.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/4.
//

import Foundation
import ComposableArchitecture

class CommunityProvider: CommunityProviderProtocol {
    
    init() {
        httpProvider = DIFactory.instance.container.resolve(HttpProviderProtocol.self)!
        authProvider = DIFactory.instance.container.resolve(AuthorizeProviderProtocol.self)!
    }
    
    private let httpProvider: HttpProviderProtocol
    private let authProvider: AuthorizeProviderProtocol
    
    func getDynamicVideoListAsync() async -> [VideoState]? {
        let queryParameters = [
            QueryKeys.typeList.rawValue: "8",
            QueryKeys.uid.rawValue: authProvider.userId!
        ]
        
        let data: ServerResponse<BiliBili.Dynamic>? = try? await httpProvider.requestAsync(url: ApiKeys.dynamic.rawValue, method: .get, queryParams: queryParameters, type: .ios, needToken: true)
        
        guard let cards = data?.data?.cards else {
            return nil
        }
        
        var set = [VideoState]()
        for card in cards {
            let d = card.toVideoState()
            set.append(d)
        }
        
        return set
    }
    
    func getRankVideoListAsync() async -> [VideoState]? {
        let data: ServerResponse<BiliBili.RankInfo>? = try? await httpProvider.requestAsync(url: ApiKeys.rank.rawValue, method: .get, queryParams: Dictionary<String, String>(), type: .web, needToken: false)
        
        guard let cards = data?.data?.list else {
            return nil
        }
        
        var set = [VideoState]()
        for card in cards {
            let d = card.toVideoState()
            set.append(d)
        }
        
        return set
    }
    
    func getTodayAnimeAsync() async -> [EpisodeState]? {
        let bangumi = await getAnimeInternal(isBangumi: true)
        let gc = await getAnimeInternal(isBangumi: false)
        
        guard bangumi != nil && gc != nil else {
            return nil
        }
        
        var set = bangumi! + gc!
        set.sort { ep1, ep2 in
            return ep1.publishTime < ep2.publishTime
        }
        
        return set
    }
    
    private func getAnimeInternal(isBangumi: Bool) async -> [EpisodeState]? {
        let queryParameters = [
            QueryKeys.types.rawValue: isBangumi ? "1" : "4",
            QueryKeys.before.rawValue: "0",
            QueryKeys.end.rawValue: "0"
        ]
        
        let data: ServerResponse2<[BiliBili.Anime]>? = try? await httpProvider.requestAsync(url: ApiKeys.timeline.rawValue, method: .get, queryParams: queryParameters, type: .web, needToken: false)
        guard let episodes = data?.result?.first?.episodes else {
            return nil
        }
        
        var set = [EpisodeState]()
        for episode in episodes {
            let ep = episode.toEpisodeState()
            set.append(ep)
        }
        
        return set
    }
}
