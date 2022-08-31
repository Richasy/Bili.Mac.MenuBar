//
//  DynamicCommunityInformation.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

/// 动态的社区信息
struct DynamicCommunityInformation {
    
    /// 动态 ID
    let id: String
    
    /// 点赞数
    var likeCount: Double
    
    /// 评论数
    let commentCount: Double
    
    /// 是否已经点赞
    let isLiked: Bool
}
