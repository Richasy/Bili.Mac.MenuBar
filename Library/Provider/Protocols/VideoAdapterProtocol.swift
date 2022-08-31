//
//  VideoAdapterProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

protocol VideoAdapterProtocol {
    
    /// 将视频动态转换为视频信息
    /// - Parameter dynamicVideo: 视频动态
    /// - Returns: 视频信息
    func convertToVideoInformation(dynamicVideo: Bilibili_App_Dynamic_V2_MdlDynArchive) -> VideoInformation
}
