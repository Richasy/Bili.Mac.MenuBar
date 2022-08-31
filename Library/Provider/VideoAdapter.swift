//
//  VideoAdapter.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

class VideoAdapter: VideoAdapterProtocol {
    
    private let communityAdapter: CommunityAdapterProtocol
    private let userAdapter: UserAdapterProtocol
    private let imageAdapter: ImageAdapterProtocol
    
    init(
        communityAdapter: CommunityAdapterProtocol,
        userAdapter: UserAdapterProtocol,
        imageAdapter: ImageAdapterProtocol) {
            self.communityAdapter = communityAdapter
            self.userAdapter = userAdapter
            self.imageAdapter = imageAdapter
    }
    
    func convertToVideoInformation(dynamicVideo: Bilibili_App_Dynamic_V2_MdlDynArchive) -> VideoInformation {
        
        var identifier: VideoIdentifier
        var alternateId: String
        var communityInfo: VideoCommunityInformation? = nil
        
        let title = dynamicVideo.title
        let cover = imageAdapter.ConvertToImage(uri: dynamicVideo.cover, width: 400, height: 300)
        
        if dynamicVideo.isPgc {
            // 处理 PGC 内容
            let ssid = String(dynamicVideo.pgcSeasonID)
            let epid = String(dynamicVideo.episodeID)
            
            alternateId = ssid
            identifier = VideoIdentifier(title: title, cover: cover, duration: 0, id: epid)
            
        } else {
            // 处理视频内容
            let id = String(dynamicVideo.avid)
            let duration = Int32(dynamicVideo.duration)
            
            alternateId = dynamicVideo.bvid
            communityInfo = communityAdapter.convertToVideoCommunityInformation(video: dynamicVideo)
            identifier = VideoIdentifier(title: title, cover: cover, duration: duration, id: id)
        }
        
        return VideoInformation(identifier: identifier, alternateId: alternateId, publishTime: nil, publisher: nil, description: nil, communityInformation: communityInfo, isPgc: dynamicVideo.isPgc)
    }
}
