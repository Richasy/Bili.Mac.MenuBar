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
}
