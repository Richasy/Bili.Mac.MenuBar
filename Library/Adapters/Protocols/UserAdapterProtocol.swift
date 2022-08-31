//
//  UserAdapterProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

protocol UserAdapterProtocol {
    
    /// 将数据整合为用户资料
    /// - Parameters:
    ///   - userId: 用户ID
    ///   - userName: 用户名
    ///   - avatar: 头像
    ///   - size: 头像尺寸
    /// - Returns: 用户资料
    func convertToUserProfile(userId: Int64, userName: String, avatar: String, size: Double) -> UserProfile
}
