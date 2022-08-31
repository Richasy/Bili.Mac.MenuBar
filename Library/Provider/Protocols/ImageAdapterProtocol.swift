//
//  ImageAdapterProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

protocol ImageAdapterProtocol {
    
    /// 将图片地址转化为 Image 类型
    /// - Parameter uri: 图片地址
    /// - Returns: Image
    func ConvertToImage(uri: String) -> Image
    
    /// 根据图片地址和宽高信息生成缩略图地址
    /// - Parameters:
    ///   - uri: 图片地址
    ///   - width: 图片宽度
    ///   - height: 图片高度
    /// - Returns: Image
    func ConvertToImage(uri: String, width: Double, height: Double) -> Image
}
