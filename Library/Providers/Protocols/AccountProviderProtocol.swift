//
//  AccountProviderProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

protocol AccountProviderProtocol {
    
    var events: EventBus { get set }
    
    /// 当前登录的用户Id
    var userId: String? { get set }
    
    /// 获取我的个人信息
    /// - Returns: 账户信息
    func getMyInformationAsync() async -> Mine?
    
    /// 获取未读消息
    /// - Returns: 消息信息
    func getUnreadMessageAsync() async -> UnreadInformation?
}
