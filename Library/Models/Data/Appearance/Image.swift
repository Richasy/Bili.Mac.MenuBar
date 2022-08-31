//
//  Image.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

struct Image: Equatable {
    
    private let sourceUri: String;
    
    init(uri: String) {
        self.sourceUri = uri
        self.uri = uri
    }
    
    init(uri: String, width: Double, height: Double, resolutionResolver: (Double, Double)->String) {
        sourceUri = uri
        self.width = width
        self.height = height
        self.uri = uri + resolutionResolver(width, height)
    }
    
    /// 预设的宽度
    var width: Double = 0
    
    /// 预设的高度
    var height: Double = 0
    
    /// 图片地址
    var uri: String
    
    /// 获取图片的原始链接
    /// - Returns: 图片地址
    func getSourceUri() -> URL? {
        return URL(string: sourceUri)
    }
    
    static func == (lhs: Image, rhs: Image) -> Bool {
        lhs.sourceUri == rhs.sourceUri
    }
}
