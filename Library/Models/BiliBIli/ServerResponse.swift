//
//  ServerResponse.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/1.
//

import Foundation

struct ServerResponse<T: Codable>: Codable {
    var code: Int32
    var message: String
    var data: T?
}

struct ServerResponse2<T: Codable>: Codable {
    var code: Int32
    var message: String
    var result: T?
}
