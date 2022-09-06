//
//  ServiceException.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/1.
//

struct ServiceException: Error, Codable {
    let code: Int32
    let message: String
}
