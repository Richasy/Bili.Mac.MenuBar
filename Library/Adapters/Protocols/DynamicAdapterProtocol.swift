//
//  DynamicAdapterProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

protocol DynamicAdapterProtocol {
    
    /// 将 gRPC 的动态条目转换为动态信息
    /// - Parameter item: 动态条目
    /// - Returns: 动态信息
    func convertToDynamicInformation(item: Bilibili_App_Dynamic_V2_DynamicItem) -> DynamicInformation
    
    
    /// 将 gRPC 的视频动态响应转换为动态视图
    /// - Parameter reply: 视频动态响应
    /// - Returns: 动态视图
    func convertToDynamicView(reply: Bilibili_App_Dynamic_V2_DynVideoReply) -> DynamicView
}
