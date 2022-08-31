//
//  CommunityAdapterProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

protocol CommunityAdapterProtocol {
    
    /// 将动态视频转换为视频社区信息
    /// - Parameter video: 动态视频
    /// - Returns: 视频社区信息
    func convertToVideoCommunityInformation(video: Bilibili_App_Dynamic_V2_MdlDynArchive) -> VideoCommunityInformation
    
    /// 将动态状态数据转换为社区信息
    /// - Parameters:
    ///   - stat: 状态数据
    ///   - dynamicId: 社区信息
    func convertToDynamicCommunityInformation(stat: Bilibili_App_Dynamic_V2_ModuleStat, dynamicId: String) -> DynamicCommunityInformation
}
