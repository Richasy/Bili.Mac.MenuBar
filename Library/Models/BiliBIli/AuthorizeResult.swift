//
//  AuthorizeResult.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/8/31.
//

import Foundation

struct AuthorizeResult {
    var state: Int32
    var message: String
    var url: String
    var tokenInfo: TokenInfo
}
