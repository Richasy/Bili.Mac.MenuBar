//
//  AccountProvider.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/3.
//

import Foundation
import SwiftUI

class AccountProvider: AccountProviderProtocol {
    
    init() {
        httpProvider = DIFactory.instance.container.resolve(HttpProviderProtocol.self)!
        userAdapter = DIFactory.instance.container.resolve(UserAdapterProtocol.self)!
        communityAdapter = DIFactory.instance.container.resolve(CommunityAdapterProtocol.self)!
        events = EventBus()
    }
    
    private let httpProvider: HttpProviderProtocol
    private let userAdapter: UserAdapterProtocol
    private let communityAdapter: CommunityAdapterProtocol
    private var accountInfo: Mine? {
        didSet {
            events.fireEvent(name: EventKeys.accountUpdated.rawValue, param: accountInfo)
        }
    }
    
    var userId: String? = nil
    var events: EventBus
    
    func getMyInformationAsync() async -> Mine? {
        let result: ServerResponse<Mine>? = try? await httpProvider.requestAsync(url: ApiKeys.mine.rawValue, method: .get, queryParams: Dictionary<String, String>(), type: .ios, needToken: true)
        
        print(result!.data!)
        guard let data = result?.data else {
            return nil
        }
        
        accountInfo = data;
        return data;
    }
    
    func getUnreadMessageAsync() async -> UnreadInformation? {
        return nil
    }
    
    
}
