//
//  CommunityAdapter.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

class CommunityAdapter: CommunityAdapterProtocol {
    
    func convertToVideoCommunityInformation(video: Bilibili_App_Dynamic_V2_MdlDynArchive) -> VideoCommunityInformation {
        let danmakuCount = Double(video.coverLeftText3.replacingOccurrences(of: "弹幕", with: ""))
        return VideoCommunityInformation(id: String(video.avid), playCount: Double(video.view), danmakuCount: danmakuCount ?? 0, likeCount: 0)
    }
    
    func convertToDynamicCommunityInformation(stat: Bilibili_App_Dynamic_V2_ModuleStat, dynamicId: String) -> DynamicCommunityInformation {
        DynamicCommunityInformation(id: dynamicId, likeCount: Double(stat.like), commentCount: Double(stat.reply), isLiked: stat.likeInfo.isLike)
    }
}
