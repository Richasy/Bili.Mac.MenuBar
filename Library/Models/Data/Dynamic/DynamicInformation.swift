//
//  DynamicInformation.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation


/// 动态信息
struct DynamicInformation : Equatable, Hashable {
    
    /// 动态 Id
    let id: String
    
    /// 发布者
    let user: UserProfile
    
    /// 提示文本，用来标识发布时间.
    let tip: String
    
    /// 动态的社区信息
    let communityInformation: DynamicCommunityInformation?
    
    /// 动态类型
    let dynamicType: DynamicType
    
    /// 动态主内容
    let data: VideoInformation
    
    /// 动态描述
    let description: String
    
    static func == (lhs: DynamicInformation, rhs: DynamicInformation) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
