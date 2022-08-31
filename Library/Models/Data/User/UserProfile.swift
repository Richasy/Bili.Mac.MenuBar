//
//  UserProfile.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

/// 用户资料
struct UserProfile: Equatable {
    
    init(id: String) {
        self.id = id
        self.name = ""
    }
    
    init(id: String, name: String, avatar: Image?) {
        self.avatar = avatar
        self.id = id
        self.name = name
    }
    
    /// 用户头像
    var avatar: Image? = nil
    
    /// 用户 id
    let id: String
    
    /// 用户名
    let name: String
    
    static func == (lhs: UserProfile, rhs: UserProfile) -> Bool {
        lhs.id == rhs.id
    }
}
