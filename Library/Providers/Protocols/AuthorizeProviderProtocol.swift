//
//  AuthorizeProviderProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import SwiftUI

protocol AuthorizeProviderProtocol {
    
    /// 当前授权状态
    var authorizeState: AuthorizeState { get }
    
    var qrCodeState: QRCodeState { get }
    
    var events: EventBus { get set }
    
    var userId: String? { get }
    
    /// 生成授权查询字符串
    /// - Parameters:
    ///   - queryParameters: 查询字典
    ///   - clienType: 客户端类型
    ///   - needToken: 是否需要令牌
    /// - Returns: 授权查询字符串
    func generateAuthorizedQueryStringAsync(queryParameters: Dictionary<String, String>, clienType: RequestClientType, needToken: Bool) async -> String
    
    /// 生成授权查询字典
    /// - Parameters:
    ///   - queryParameters: 查询字典
    ///   - clientType: 客户端类型
    ///   - needToken: 是否需要令牌
    /// - Returns: 授权查询字符串
    func generateAuthorizeQueryDictionaryAsync(queryParameters: Dictionary<String, String>, clientType: RequestClientType, needToken: Bool) async -> Dictionary<String, String>
    
    /// 获取令牌
    /// - Returns: 令牌
    func getTokenAsync() async -> String
    
    /// 尝试登录
    func trySignInAsync() async
    
    /// 循环检查二维码状态
    func loopQRCodeStatusAsync() async
    
    /// 获取登录二维码
    func getQRCodeImageAsync() async -> String
    
    /// 退出
    func signOut()
    
    /// 令牌是否有效
    /// - Parameter isNetworkVerify: 是否联网认证
    /// - Returns: 认证结果
    func isTokenValidAsync(isNetworkVerify: Bool) async -> Bool
}
