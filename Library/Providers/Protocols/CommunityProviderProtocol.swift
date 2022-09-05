//
//  CommunityProviderProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import ComposableArchitecture

protocol CommunityProviderProtocol {
    
    /// 获取视频动态列表
    /// - Returns: 视频动态集合
    func getDynamicVideoListAsync() async -> [VideoState]?
}
