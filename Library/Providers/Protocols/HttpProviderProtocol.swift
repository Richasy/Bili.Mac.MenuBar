//
//  HttpProviderProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

protocol HttpProviderProtocol {
    
    /// 请求服务
    var client: URLSession { get }
    
    /// 获取请求消息
    /// - Parameters:
    ///   - method: 请求类型
    ///   - url: 请求地址
    ///   - queryParams: 携带的查询参数
    ///   - type: 使用的令牌类型
    ///   - needToken: 是否需要令牌
    /// - Returns: 请求体
    func getRequestMessage(method: String, url: String, queryParams: Dictionary<String, String>, type: RequestClientType, needToken: Bool) -> URLRequest
    
    /// 发送请求
    /// - Parameter request: 请求体
    /// - Returns: 响应结果
    func send(request: URLRequest) -> URLResponse
    
    /// 将响应结果转换为制定类型的数据
    /// - Parameter response: 响应结果
    /// - Returns: 制定类型的数据
    func parse<T>(response: URLResponse) -> T
}
