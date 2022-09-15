//
//  HttpProvider.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/2.
//

import Foundation
import Alamofire
import SwiftProtobuf

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
    
    func requestAsync(url: String, message: SwiftProtobuf.Message, needToken: Bool = false) async throws -> Data? {
        let isTokenValid = await authProvider.isTokenValidAsync(isNetworkVerify: false)
        let token = needToken || isTokenValid ? (try? await authProvider.getTokenAsync()) ?? "" : ""
        let grpcConfig = GRPCConfig(accessToken: token)
        let userAgent = "bili-universal/62800300 "
        + "os/ios model/\(grpcConfig.model) mobi_app/iphone "
        + "osVer/\(grpcConfig.osVersion) "
        + "network/\(grpcConfig.networkType) "
        + "grpc-objc/1.32.0 grpc-c/12.0.0 (ios; cronet_http)"
        var headers: HTTPHeaders = [
            ServiceKeys.contentType.rawValue: ServiceKeys.gRPCContentType.rawValue,
            ServiceKeys.userAgent.rawValue: userAgent,
            ServiceKeys.appKey.rawValue: grpcConfig.mobileApp,
            ServiceKeys.biliDevice.rawValue: grpcConfig.getDeviceBin(),
            ServiceKeys.biliFawkes.rawValue: grpcConfig.getFawkesReqBin(),
            ServiceKeys.biliLocale.rawValue: grpcConfig.getLocaleBin(),
            ServiceKeys.biliMeta.rawValue: grpcConfig.getMetadataBin(),
            ServiceKeys.biliNetwork.rawValue: grpcConfig.getNetworkBin(),
            ServiceKeys.biliRestriction.rawValue: grpcConfig.getRestrictionBin(),
            ServiceKeys.gRPCAcceptEncodingKey.rawValue: ServiceKeys.gRPCAcceptEncodingValue.rawValue,
            ServiceKeys.gRPCTimeOutKey.rawValue: ServiceKeys.gRPCTimeOutValue.rawValue,
            ServiceKeys.envoriment.rawValue: grpcConfig.enviroment,
            ServiceKeys.transferEncodingKey.rawValue: ServiceKeys.transferEncodingValue.rawValue,
            ServiceKeys.teKey.rawValue: ServiceKeys.teValue.rawValue
        ]
        
        if !token.isEmpty {
            headers.add(name: "Authorization", value: "\(ServiceKeys.identify.rawValue) \(token)")
        }
        
        var data = try! message.serializedData()
        data.insert(UInt8(data.count), at: 0)
        for _ in 1...4 {
            data.insert(0, at: 0)
        }
        
        let dataTask = AF.request(url, method: .post, parameters: nil, encoding: ByteEncoding(data: data), headers: headers, requestModifier: {$0.allowsConstrainedNetworkAccess = true})
            .validate(statusCode: 200..<300)
            .serializingData()
        let response = await dataTask.response
        guard (200..<300).contains(response.response?.statusCode ?? 500) else {
            print(response.description)
            print(response.error ?? "请求出错")
            throw ServiceException(code: Int32(response.response?.statusCode ?? -1), message: "请求失败")
        }
        
        var result = response.data
        result?.removeSubrange(0..<5)
        
        return result
    }
    
    struct ByteEncoding: ParameterEncoding {
      private let data: Data

      init(data: Data) {
        self.data = data
      }

      func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        urlRequest.httpBody = data
        return urlRequest
      }
    }
}
