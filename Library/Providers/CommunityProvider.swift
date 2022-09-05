//
//  CommunityProvider.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/4.
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
        
        guard let cards = data!.data?.cards else {
            return nil
        }
        
        var set = [VideoState]()
        for card in cards {
            let d = card.toVideoState()
            set.append(d)
        }
        
        return set
    }
}
