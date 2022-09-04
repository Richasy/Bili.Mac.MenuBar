//
//  ServerResponse.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/1.
//

import Foundation

struct ServerResponse<T: Codable>: Codable {
    var code: Int32
    var message: String
    var data: T?
}
