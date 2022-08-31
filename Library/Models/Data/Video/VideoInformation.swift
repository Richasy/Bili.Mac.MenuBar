//
//  VideoInformation.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

/// 视频信息
struct VideoInformation: Hashable, Equatable {
    
    /// 视频标识
    let identifier: VideoIdentifier
    
    /// 备用 Id，通常是指 bvid
    var alternateId: String
    
    /// 发布时间
    let publishTime: Date?
    
    /// 发布者
    var publisher: UserProfile?
    
    /// 视频描述
    let description: String?
    
    /// 社区信息
    let communityInformation: VideoCommunityInformation
    
    /// 是否为 PGC 内容
    let isPgc: Bool
    
    static func == (lhs: VideoInformation, rhs: VideoInformation) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
