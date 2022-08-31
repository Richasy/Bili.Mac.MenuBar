//
//  AccountProviderProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

protocol AccountProviderProtocol {
    
    /// 当前登录的用户Id
    var userId: String? { get set }
    
    /// 获取我的个人信息
    /// - Returns: 账户信息
    func getMyInformation() -> AccountInformation
    
    /// 获取我的社区信息
    /// - Returns: 社区信息
    func getMyCommunityInformation() -> UserCommunityInformation
}
