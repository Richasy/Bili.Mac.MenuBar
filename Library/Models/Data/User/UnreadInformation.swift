//
//  UnreadInformation.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/3.
//

import Foundation

struct UnreadInformation {
    let atCount: Int32
    let replyCount: Int32
    let likeCount: Int32
    
    var total: Int32 {
        get {
            return atCount + replyCount + likeCount
        }
    }
}
