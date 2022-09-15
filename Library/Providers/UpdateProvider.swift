//
//  UpdateProvider.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/10.
//

import Foundation
import Alamofire

class UpdateProvider: UpdateProviderProtocol {
    
    private let releaseUrl = "https://api.github.com/repos/Richasy/Bili.Mac.MenuBar/releases/latest"
    
    func hasUpdateAsync() async -> Bool? {
        let headers: HTTPHeaders = [
            "Accept": ServiceKeys.acceptString.rawValue,
            "User-Agent": ServiceKeys.webAgent.rawValue
        ]
        
        let dataTask = AF.request(releaseUrl, method: .get, headers: headers, requestModifier: {$0.allowsConstrainedNetworkAccess = true})
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .serializingData()
        let response = await dataTask.response
        guard (200..<300).contains(response.response?.statusCode ?? 500) else {
            print(response.error ?? "请求出错")
            return nil
        }
        
        do {
            let jsonObj = try JSONDecoder().decode(GithubRelease.self, from: response.data!)
            return jsonObj.tag_name != Bundle.main.releaseVersionNumberaPretty
        } catch {
            print(error)
            return nil
        }
    }
    
    struct GithubRelease: Codable {
        var html_url: String
        var tag_name: String
        var name: String
        var prerelease: Bool
        var body: String
    }
}
