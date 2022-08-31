//
//  IMD5Toolkit.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

protocol MD5ToolkitProtocol {
    
    /// 获取转换后的MD5字符串
    /// - Parameter source: 输入的字符串
    /// - Returns: 转换后的结果
    func getMd5String(_ source: String) -> String
}
