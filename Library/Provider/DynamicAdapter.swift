//
//  DynamicAdapter.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

class DynamicAdapter: DynamicAdapterProtocol {
    
    private let videoAdapter: VideoAdapterProtocol
    private let userAdapter: UserAdapterProtocol
    private let communityAdapter: CommunityAdapterProtocol
    
    init(
        videoAdapter: VideoAdapterProtocol,
        userAdapter: UserAdapterProtocol,
        communityAdapter: CommunityAdapterProtocol) {
            self.videoAdapter = videoAdapter
            self.userAdapter = userAdapter
            self.communityAdapter = communityAdapter
    }
    
    func convertToDynamicInformation(item: Bilibili_App_Dynamic_V2_DynamicItem) -> DynamicInformation {
        let modules = item.modules
        let userModule = modules.first(where: {$0.moduleType == .moduleAuthor})?.moduleAuthor
        let descModule = modules.first(where: {$0.moduleType == .moduleDesc})?.moduleDesc
        let mainModule = modules.first(where: {$0.moduleType == .moduleDynamic})?.moduleDynamic
        let dataModule = modules.first(where: {$0.moduleType == .moduleStat})?.moduleStat
        
        var user: UserProfile = UserProfile(id: "", name: "佚名", avatar: nil)
        var tip: String = ""
        var description: String = ""
        var communityInfo: DynamicCommunityInformation? = nil
        
        let dynamicId = item.extend.dynIDStr
        let dynamicType = getDynamicType(dynamic: mainModule)
        let dynamicData = getDynamicContent(dynamic: mainModule!)
        
        if userModule != nil {
            let author = userModule?.author
            user = userAdapter.convertToUserProfile(userId: author?.mid ?? 0, userName: author?.name ?? "", avatar: author?.face ?? "", size: 90)
            tip = userModule?.ptimeLabelText ?? ""
        }
        
        if descModule != nil {
            description = descModule?.text ?? ""
        }
        
        if dataModule != nil {
            communityInfo = communityAdapter.convertToDynamicCommunityInformation(stat: dataModule!, dynamicId: dynamicId)
        }
        
        return DynamicInformation(id: dynamicId, user: user, tip: tip, communityInformation: communityInfo, dynamicType: dynamicType, data: dynamicData, description: description)
    }
    
    func convertToDynamicView(reply: Bilibili_App_Dynamic_V2_DynVideoReply) -> DynamicView {
        let list = reply.dynamicList.list.filter({$0.cardType == .av || $0.cardType == .pgc || $0.cardType == .ugcSeason}).map({convertToDynamicInformation(item: $0)})
        
        return DynamicView(dynamics: Set(list))
    }
    
    private func getDynamicType(dynamic: Bilibili_App_Dynamic_V2_ModuleDynamic?) -> DynamicType {
        guard dynamic != nil else {
            return .plainText
        }
        
        var type: DynamicType = .unsupported
        switch dynamic?.type {
        case .mdlDynArchive:
            if dynamic?.dynArchive.isPgc ?? false {
                type = .pgc
            } else {
                type = .video
            }
        case .mdlDynPgc:
            type = .pgc
        case .mdlDynForward:
            type = .forward
        case .mdlDynDraw:
            type = .image
        case .mdlDynArticle:
            type = .article
        default:
            break
        }
        
        return type
    }
    
    private func getDynamicContent(dynamic: Bilibili_App_Dynamic_V2_ModuleDynamic) -> VideoInformation {
        videoAdapter.convertToVideoInformation(dynamicVideo: dynamic.dynArchive)
    }
}
