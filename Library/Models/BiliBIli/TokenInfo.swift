//
//  TokenInfo.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

struct TokenInfo: Codable {
    var mid: Int64
    var acessToken: String
    var refreshToken: String
    var expiresIn: Int32
}
