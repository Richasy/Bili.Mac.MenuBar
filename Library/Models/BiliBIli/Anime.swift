//
//  Anime.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/6.
//

import Foundation

extension BiliBili {
    // MARK: - Anime
    struct Anime: Codable {
        let date: String
        let date_ts, day_of_week: Int
        let episodes: [Episode]
    }

    // MARK: - Episode
    struct Episode: Codable {
        let cover: String
        let ep_cover: String
        let episode_id: Int
        let pub_index, pub_time: String
        let pub_ts, published, season_id: Int
        let square_cover: String
        let title: String
    }
}
