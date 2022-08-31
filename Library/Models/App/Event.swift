//
//  Event.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

struct Event<T>: Hashable, Equatable {
    
    let id: String
    let event: (T)->Void
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Event<T>, rhs: Event<T>) -> Bool {
        lhs.id == rhs.id
    }
}
