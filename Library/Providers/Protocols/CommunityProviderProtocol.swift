//
//  CommunityProviderProtocol.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/8/31.
//

import ComposableArchitecture

protocol CommunityProviderProtocol {
    
    /// 获取视频动态列表
    /// - Returns: 视频动态集合
    func getDynamicVideoListAsync() async -> [VideoState]?
    
    /// 获取总排行榜
    /// - Returns: 排行榜视频集合
    func getRankVideoListAsync() async -> [VideoState]?
    
    /// 获取今日动漫（包括番剧和国创）
    /// - Returns: 动漫列表
    func getTodayAnimeAsync() async -> [EpisodeState]?
    
    /// 获取热搜列表
    /// - Returns: 热搜列表
    func getHotSearchAsync() async -> [HotSearchItemState]?
}
