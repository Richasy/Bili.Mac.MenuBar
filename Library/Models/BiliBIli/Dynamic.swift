// This file was generated from JSON Schema using codebeautify, do not modify it directly.
// To parse the JSON, add this file to your project and do:

import Foundation
import SwiftUI

class BiliBili {
    // MARK: - Dynamic
    struct Dynamic: Codable {
        let cards: [CardElement]
    }

    // MARK: - CardElement
    struct CardElement: Codable {
        let desc: Desc
        let card, extend_json: String
        
        static func == (lhs: BiliBili.CardElement, rhs: BiliBili.CardElement) -> Bool {
            return lhs.desc.dynamic_id == rhs.desc.dynamic_id
        }
    }

    // MARK: - Desc
    class Desc: Codable {
        let uid, type, rid, view: Int
        let repost: Int
        let like, is_liked: Int?
        let dynamic_id, timestamp: Int
        let user_profile: UserProfile?
        let status: Int
        let dynamic_id_str: String
        let bvid: String
        let stype: Int?
        let origin: Desc?
    }

    // MARK: - UserProfile
    struct UserProfile: Codable {
        let info: Info
    }

    // MARK: - Info
    struct Info: Codable {
        let uid: Int
        let uname: String
        let face: String
    }
    
    struct CardDetail: Codable {
        let aid: Int
        let desc: String
        let duration: Int
        let pic: String
        let pubdate: Int
        let short_link_v2: String
        let stat: [String: Int]
        let title: String
        let owner: Owner
    }
    
    struct Owner: Codable {
        let mid: Int
        let name: String
        let face: String
    }
}
