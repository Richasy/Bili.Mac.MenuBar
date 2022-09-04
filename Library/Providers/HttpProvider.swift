//
//  HttpProvider.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/2.
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
            
            if let cookieArray = UserDefaults.standard.array(forKey: "Cookies") {
                for cookieData in cookieArray {
                    if let dict = cookieData as? [HTTPCookiePropertyKey : Any] {
                        if let cookie = HTTPCookie.init(properties : dict) {
                            HTTPCookieStorage.shared.setCookie(cookie)
                        }
                    }
                }
            }
            
            let query = await authProvider.generateAuthorizeQueryDictionaryAsync(queryParameters: queryParams, clientType: type, needToken: needToken)
            let headers: HTTPHeaders = [
                "Accept": ServiceKeys.acceptString.rawValue,
                "User-Agent": ServiceKeys.userAgent.rawValue
            ]
            
            let dataTask = AF.request(url, method: method, parameters: query, encoder: URLEncodedFormParameterEncoder(destination: method == .get ? .queryString : .httpBody), headers: headers, requestModifier: {$0.allowsConstrainedNetworkAccess = true})
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .serializingData()
            
            let response = await dataTask.response
            print(response.request?.url?.absoluteString ?? "没有地址")
            guard (200..<300).contains(response.response!.statusCode) else {
                throw ServiceException(code: Int32(response.response!.statusCode), message: "请求失败")
            }
            
            let shouldSaveCookie = url == ApiKeys.tokenInfo.rawValue
            if shouldSaveCookie {
                let headerFields = response.response?.allHeaderFields as! [String: String]
                let url = response.request?.url
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url!)
                var cookieArray = [[HTTPCookiePropertyKey : Any ]]()
                for cookie in cookies {
                    cookieArray.append(cookie.properties!)
                }
                
                print(headerFields)
                print(cookies)
                UserDefaults.standard.set(cookieArray, forKey: "Cookies")
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
