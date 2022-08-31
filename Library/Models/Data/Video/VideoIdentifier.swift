//
//  VideoIdentifier.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

/// 视频标识
struct VideoIdentifier: Hashable, Equatable {
    
    let title: String
    let cover: Image
    let duration: Int32
    let id: String
    
    static func == (lhs: VideoIdentifier, rhs: VideoIdentifier) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
