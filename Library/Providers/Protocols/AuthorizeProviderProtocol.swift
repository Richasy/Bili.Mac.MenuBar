//
//  AuthorizeProviderProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

protocol AuthorizeProviderProtocol {
    
    /// 状态变化通知列表
    var authorizeStateChangedNotifyList: Set<Event<AuthorizeStateChangedEventArgs>> { get }
    
    /// 状态变化通知列表
    var qrCodeStateChangedNotifyList: Set<Event<QRCodeStateChangedEventArgs>> { get }
    
    /// 当前授权状态
    var state: AuthorizeState { get }
    
    /// 生成授权查询字符串
    /// - Parameters:
    ///   - queryParameters: 查询字典
    ///   - clienType: 客户端类型
    ///   - needToken: 是否需要令牌
    /// - Returns: 授权查询字符串
    func generateAuthorizedQueryStringAsync(queryParameters: Dictionary<String, String>, clienType: RequestClientType, needToken: Bool) -> String
    
    /// 生成授权查询字典
    /// - Parameters:
    ///   - queryParameters: 查询字典
    ///   - clientType: 客户端类型
    ///   - needToken: 是否需要令牌
    /// - Returns: 授权查询字符串
    func generateAuthorizeQueryDictionary(queryParameters: Dictionary<String, String>, clientType: RequestClientType, needToken: Bool) -> Dictionary<String, String>
    
    /// 获取令牌
    /// - Returns: 令牌
    func getToken() -> String
    
    /// 尝试登录
    /// - Returns: 登录结果
    func trySignIn() -> Bool
    
    /// 退出
    func signOut()
    
    /// 令牌是否有效
    /// - Parameter isNetworkVerify: 是否联网认证
    /// - Returns: 认证结果
    func isTokenValid(isNetworkVerify: Bool) -> Bool
}
