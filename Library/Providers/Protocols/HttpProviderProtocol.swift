//
//  HttpProviderProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/8/31.
//

import Foundation
import Alamofire
import SwiftProtobuf

protocol HttpProviderProtocol {
    
    /// 发送请求并获取返回值
    /// - Parameters:
    ///   - method: 请求类型
    ///   - url: 请求地址
    ///   - queryParams: 携带的查询参数
    ///   - type: 使用的令牌类型
    ///   - needToken: 是否需要令牌
    /// - Returns: 结果
    func requestAsync<T: Codable>(url: String, method: HTTPMethod, queryParams: Dictionary<String, String>, type: RequestClientType, needToken: Bool) async throws -> T
    
    /// 发送grpc请求并获取返回数据
    /// - Parameters:
    ///   - url: 请求地址
    ///   - message: 请求消息
    ///   - needToken: 是否需要令牌
    /// - Returns: 结果
    func requestAsync(url: String, message: SwiftProtobuf.Message, needToken: Bool) async throws -> Data?
}
