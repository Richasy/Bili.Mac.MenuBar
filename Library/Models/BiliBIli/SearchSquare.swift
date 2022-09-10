//
//  SearchSquare.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/9.
//

import Foundation

struct SearchSquareItem: Codable {
    var type: String
    var title: String?
    var data: SearchSquareData?
}

struct SearchSquareData: Codable {
    var trackid: String?
    var list: [SearchRecommentItem]?
    var title: String?
}

struct SearchRecommentItem: Codable {
    var keyword: String?
    var show_name: String?
    var icon: String?
    var position: Int?
}
