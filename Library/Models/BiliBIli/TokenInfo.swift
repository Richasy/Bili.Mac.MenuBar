//
//  TokenInfo.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/8/31.
//

import Foundation

struct TokenInfo: Codable {
    var mid: Int64
    var access_token: String
    var refresh_token: String
    var expires_in: Int32
    var cookie_info: CookieInfo
}

struct CookieInfo: Codable {
    var cookies: [CookieInfoItem]
    var domains: [String]
}

struct CookieInfoItem: Codable {
    var name: String
    var value: String
    var http_only: Int
    var expires: Double
    var secure: Int
}
