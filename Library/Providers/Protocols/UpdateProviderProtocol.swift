//
//  UpdateProviderProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/10.
//

import Foundation

protocol UpdateProviderProtocol {
    
    /// 是否有更新
    /// - Returns: 检查结果
    func hasUpdateAsync() async -> Bool?
}
