//
//  HttpProvider.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/2.
//

import Foundation

class HttpProvider: HttpProviderProtocol {
    var client: URLSession
    private let authProvider: AuthorizeProviderProtocol
    
    init(authProvider: AuthorizeProviderProtocol) {
        self.authProvider = authProvider
        client = URLSession.shared
    }
    
    func getRequestMessageAsync(method: String, url: String, queryParams: Dictionary<String, String>, type: RequestClientType, needToken: Bool) async -> URLRequest {
        var requestMessage: URLRequest
        
        if method == "GET" || method == "DELETE" {
            let query = await authProvider.generateAuthorizedQueryStringAsync(queryParameters: queryParams, clienType: type, needToken: needToken)
            let requestUrl = url + "?\(query)"
            requestMessage = URLRequest(url: URL(string: requestUrl)!)
        } else {
            let query = await authProvider.generateAuthorizeQueryDictionaryAsync(queryParameters: queryParams, clientType: type, needToken: needToken)
            requestMessage = URLRequest(url: URL(string: url)!)
            requestMessage.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            var urlComponents = URLComponents()
            for param in query {
                urlComponents.queryItems?.append(URLQueryItem(name: param.key, value: param.value))
            }
            
            requestMessage.httpBody = urlComponents.query?.data(using: .utf8)
        }
        
        requestMessage.httpMethod = method
        return requestMessage
    }
    
    func sendAsync<T>(_ t:T.Type, request: URLRequest) async throws -> T where T : Decodable, T : Encodable {
        do {
            let (data, response) = try await client.data(for: request)
            let res = response as! HTTPURLResponse
            guard (200...299).contains(res.statusCode) else {
                throw ServiceException(code: Int32(res.statusCode), message: "请求失败")
            }
            
            let jsonObj = try JSONDecoder().decode(T.self, from: data)
            return jsonObj
        } catch {
            if error is ServiceException {
                throw error
            } else {
                throw ServiceException(code: -1, message: error.localizedDescription)
            }
        }
    }
}
