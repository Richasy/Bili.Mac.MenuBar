//
//  ServiceException.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/1.
//

struct ServiceException: Error, Codable {
    let code: Int32
    let message: String
}
