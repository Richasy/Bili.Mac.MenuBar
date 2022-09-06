//
//  HttpProvider.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/2.
//

import Foundation
import Alamofire

class HttpProvider: HttpProviderProtocol {
    private let authProvider: AuthorizeProviderProtocol
    
    init(authProvider: AuthorizeProviderProtocol) {
        self.authProvider = authProvider
    }
    
    func requestAsync<T: Codable>(url: String, method: HTTPMethod, queryParams: Dictionary<String, String>, type: RequestClientType, needToken: Bool) async throws -> T {
        
        do {
            let query = type == .web && !needToken ? queryParams : await authProvider.generateAuthorizeQueryDictionaryAsync(queryParameters: queryParams, clientType: type, needToken: needToken)
            let headers: HTTPHeaders = [
                "Accept": ServiceKeys.acceptString.rawValue,
                "User-Agent": ServiceKeys.userAgent.rawValue
            ]
            
            let dataTask = AF.request(url, method: method, parameters: query, encoder: URLEncodedFormParameterEncoder(destination: method == .get ? .queryString : .httpBody), headers: headers, requestModifier: {$0.allowsConstrainedNetworkAccess = true})
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .serializingData()
            let response = await dataTask.response
            guard (200..<300).contains(response.response?.statusCode ?? 500) else {
                print(response.error ?? "请求出错")
                throw ServiceException(code: Int32(response.response?.statusCode ?? -1), message: "请求失败")
            }
            
            let jsonObj = try JSONDecoder().decode(T.self, from: response.data!)
            return jsonObj
        } catch {
            print(error)
            if error is ServiceException {
                throw error
            } else {
                throw ServiceException(code: -1, message: error.localizedDescription)
            }
        }
    }
}
