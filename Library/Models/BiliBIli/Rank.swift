//
//  Rank.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/6.
//

import Foundation

extension BiliBili {
    struct RankInfo: Codable {
        var note: String
        var list: [CardDetail]
    }
}
