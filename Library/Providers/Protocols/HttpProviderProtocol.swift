//
//  HttpProviderProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation
import Alamofire

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
}
