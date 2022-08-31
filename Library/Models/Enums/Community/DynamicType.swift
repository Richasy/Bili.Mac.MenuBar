//
//  DynamicType.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

/// 动态类型.
enum DynamicType {
    
    /// 不支持的动态类型.
    case unsupported
    
    /// 视频动态
    case video
    
    /// PGC 动态
    case pgc
    
    /// 文章
    case article
    
    /// 图文
    case image
    
    /// 纯文本
    case plainText
    
    /// 转发
    case forward
}
