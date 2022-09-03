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
            requestMessage.encodeParameters(parameters: query)
        }
        
        requestMessage.setValue(ServiceKeys.acceptString.rawValue, forHTTPHeaderField: "Accept")
        requestMessage.setValue(ServiceKeys.userAgent.rawValue, forHTTPHeaderField: "User-Agent")
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
            print(error)
            if error is ServiceException {
                throw error
            } else {
                throw ServiceException(code: -1, message: error.localizedDescription)
            }
        }
    }
}

extension URLRequest {
    
    private func percentEscapeString(_ string: String) -> String {
        var characterSet = CharacterSet.alphanumerics
        characterSet.insert(charactersIn: "-._* ")
        
        return string
            .addingPercentEncoding(withAllowedCharacters: characterSet)!
            .replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
    }
    
    mutating func encodeParameters(parameters: [String : String]) {
        httpMethod = "POST"
        
        let parameterArray = parameters.map { (arg) -> String in
            let (key, value) = arg
            return "\(key)=\(self.percentEscapeString(value))"
        }
        
        httpBody = parameterArray.joined(separator: "&").data(using: String.Encoding.utf8)
    }
}
