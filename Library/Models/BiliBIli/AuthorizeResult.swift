//
//  AuthorizeResult.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

struct AuthorizeResult {
    var state: Int32
    var message: String
    var url: String
    var tokenInfo: TokenInfo
}
