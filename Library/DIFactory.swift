//
//  DIFactory.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation
import Swinject
import SwinjectAutoregistration

struct DIFactory {
    
    static var instance: DIFactory = DIFactory()
    
    init() {
        print("di 被构造了")
        container = Container()
        
        container.autoregister(MD5ToolkitProtocol.self, initializer: MD5Toolkit.init).inObjectScope(.container)
        
        container.autoregister(ImageAdapterProtocol.self, initializer: ImageAdapter.init).inObjectScope(.container)
        
        container.autoregister(AuthorizeProviderProtocol.self, initializer: AuthorizeProvider.init).inObjectScope(.container)
        container.autoregister(HttpProviderProtocol.self, initializer: HttpProvider.init).inObjectScope(.container)
        container.autoregister(AccountProviderProtocol.self, initializer: AccountProvider.init).inObjectScope(.container)
        container.autoregister(CommunityProviderProtocol.self, initializer: CommunityProvider.init).inObjectScope(.container)
    }
    
    let container: Container
}
