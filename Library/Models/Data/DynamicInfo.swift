//
//  DynamicCard.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/4.
//

import Foundation

struct DynamicInfo: Codable, Equatable, Hashable, Identifiable {
    var upAvatar: String
    var upName: String
    var label: String
    var cover: String
    var title: String
    var playCount: Int32
    var danmuCount: Int32
    var id: String
    var videoId: String
    var link: String
    
    static func == (lhs: DynamicInfo, rhs: DynamicInfo) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
