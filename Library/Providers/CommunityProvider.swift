//
//  CommunityProvider.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/4.
//

import Foundation

class CommunityProvider: CommunityProviderProtocol {
    
    init() {
        httpProvider = DIFactory.instance.container.resolve(HttpProviderProtocol.self)!
        authProvider = DIFactory.instance.container.resolve(AuthorizeProviderProtocol.self)!
    }
    
    private let httpProvider: HttpProviderProtocol
    private let authProvider: AuthorizeProviderProtocol
    
    func getDynamicVideoListAsync() async -> [DynamicInfo]? {
        let queryParameters = [
            QueryKeys.typeList.rawValue: "8",
            QueryKeys.uid.rawValue: authProvider.userId!
        ]
        
        let data: ServerResponse<BiliBili.Dynamic>? = try? await httpProvider.requestAsync(url: ApiKeys.dynamic.rawValue, method: .get, queryParams: queryParameters, type: .ios, needToken: true)
        
        guard let cards = data!.data?.cards else {
            return nil
        }
        
        var set = [DynamicInfo]()
        for card in cards {
            let avatar = card.desc.user_profile!.info.face + "@60w_60h_1c_1s.jpg"
            let upName = card.desc.user_profile?.info.uname
            let playCount = card.desc.view
            let cardData = card.card.data(using: .utf8)
            let cardDetail = try? JSONDecoder().decode(BiliBili.CardDetail.self, from: cardData!)
            let cover = cardDetail!.pic + "@240w_160h_1c_1s.jpg"
            let title = cardDetail!.title
            let formatter = DateFormatter()
            formatter.locale = Locale.init(identifier: "zh_CN")
            formatter.dateFormat = "MM-dd HH:mm"
            let label = formatter.string(from: Date(timeIntervalSince1970: Double(cardDetail!.pubdate)))
            
            let d = DynamicInfo(upAvatar: avatar, upName: upName!, label: label, cover: cover, title: title, playCount: Int32(playCount), danmuCount: Int32(cardDetail!.stat["danmaku"]!), id: card.desc.dynamic_id_str, videoId: card.desc.bvid, link: cardDetail!.short_link_v2)
            
            set.append(d)
        }
        
        return set
    }
}
