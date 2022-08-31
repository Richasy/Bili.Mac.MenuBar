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
        container = Container()
        container.autoregister(ImageAdapterProtocol.self, initializer: ImageAdapter.init)
        container.autoregister(UserAdapterProtocol.self, initializer: UserAdapter.init)
        container.autoregister(CommunityAdapterProtocol.self, initializer: CommunityAdapter.init)
        container.autoregister(VideoAdapterProtocol.self, initializer: VideoAdapter.init)
        container.autoregister(DynamicAdapterProtocol.self, initializer: DynamicAdapter.init)
    }
    
    let container: Container
}
