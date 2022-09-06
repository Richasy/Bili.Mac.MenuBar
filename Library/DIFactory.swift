//
//  DIFactory.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/8/31.
//

import Foundation
import Swinject
import SwinjectAutoregistration

struct DIFactory {
    
    static var instance: DIFactory = DIFactory()
    
    init() {
        print("di 被构造了")
        container = Container()
        container.autoregister(AuthorizeProviderProtocol.self, initializer: AuthorizeProvider.init).inObjectScope(.container)
        container.autoregister(HttpProviderProtocol.self, initializer: HttpProvider.init).inObjectScope(.container)
        container.autoregister(AccountProviderProtocol.self, initializer: AccountProvider.init).inObjectScope(.container)
        container.autoregister(CommunityProviderProtocol.self, initializer: CommunityProvider.init).inObjectScope(.container)
    }
    
    let container: Container
}
