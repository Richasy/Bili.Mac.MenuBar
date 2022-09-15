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
        let bangumi = await getAnimeInternalAsync(isBangumi: true)
        let gc = await getAnimeInternalAsync(isBangumi: false)
        
        guard bangumi != nil && gc != nil else {
            return nil
        }
        
        var set = bangumi! + gc!
        set.sort { ep1, ep2 in
            return ep1.publishTime < ep2.publishTime
        }
        
        return set
    }
    
    func getHotSearchAsync() async -> [HotSearchItemState]? {
        let queryParameters = [
            QueryKeys.device.rawValue: "phone",
            QueryKeys.from.rawValue: "0",
            QueryKeys.limit.rawValue: "50"
        ]
        
        let data: ServerResponse<[SearchSquareItem]>? = try? await httpProvider.requestAsync(url: ApiKeys.hotSearch.rawValue, method: .get, queryParams: queryParameters, type: .ios, needToken: false)
        guard let hotSet = data?.data?.first(where: { item in
            return item.type == "trending"
        })?.data?.list else {
            return nil
        }
        
        var set = [HotSearchItemState]()
        for searchItem in hotSet {
            let hot = searchItem.toHotItemState()
            set.append(hot)
        }
        
        return set
    }
    
    func getPopularVideoListAsync() async -> [VideoState]? {
        var set = [VideoState]()
        var lastIdx: Int64 = 0
        let loopCount = 3
        
        for _ in 1...loopCount {
            let req = await getPopularVideoInternalAsync(offsetId: lastIdx)
            if req.1 != -1 {
                lastIdx = req.1
                set = set + req.0!
            } else {
                break
            }
        }
        
        return set.count == 0 ? nil : set
    }
    
    private func getAnimeInternalAsync(isBangumi: Bool) async -> [EpisodeState]? {
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
    
    private func getPopularVideoInternalAsync(offsetId: Int64 = 0) async -> ([VideoState]?, Int64) {
        var req = Bilibili_App_Show_V1_PopularResultReq()
        req.idx = offsetId
        req.loginEvent = 2
        req.qn = 112
        req.fnval = 464
        req.fourk = 1
        req.spmid = "creation.hot-tab.0.0"
        let data = try? await httpProvider.requestAsync(url: ApiKeys.popular.rawValue, message: req, needToken: true)
        
        guard let data = data else {
            return (nil, -1)
        }
        
        let reply = try? Bilibili_App_Show_V1_PopularReply(serializedData: data)
        guard let reply = reply else {
            return (nil, -1)
        }
        
        var set = [VideoState]()
        for item in reply.items.filter({ c in
            return c.smallCoverV5.base.cardGoto == "av"
        }) {
            let d = item.toVideoState()
            set.append(d)
        }
        
        let lastIdx = reply.items.last?.smallCoverV5.base.idx
        
        return (set, lastIdx!)
    }
}
