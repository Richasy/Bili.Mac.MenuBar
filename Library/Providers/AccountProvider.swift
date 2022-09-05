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
    }
    
    private let httpProvider: HttpProviderProtocol
    private var accountInfo: Mine?
    private var unreadInfo: UnreadInfo?
    
    func getMyInformationAsync() async -> Mine? {
        let result: ServerResponse<Mine>? = try? await httpProvider.requestAsync(url: ApiKeys.mine.rawValue, method: .get, queryParams: Dictionary<String, String>(), type: .ios, needToken: true)
        
        guard let data = result?.data else {
            return nil
        }
        
        accountInfo = data;
        return data;
    }
    
    func getUnreadMessageAsync() async -> UnreadInfo? {
        let result: ServerResponse<UnreadInfo>? = try? await httpProvider.requestAsync(url: ApiKeys.message.rawValue, method: .get, queryParams: Dictionary<String, String>(), type: .ios, needToken: true)
        
        guard let data = result?.data else {
            return nil
        }
        
        return data
    }
}
