//
//  Extensions.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/5.
//

import Foundation
import CommonCrypto

extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: 1)
        
        return String(format: hash as String)
    }
    
    func resizeImage(w: Int32, h: Int32) -> String {
        return "\(self.replacingOccurrences(of: "http:", with: "https:"))@\(w)w_\(h)h_1c_100q.jpg"
    }
    
    func toDynamicCardDetail() -> BiliBili.CardDetail {
        let cardData = self.data(using: .utf8)
        let cardDetail = try? JSONDecoder().decode(BiliBili.CardDetail.self, from: cardData!)
        return cardDetail!
    }
    
    func toCountNumber(removeText: String = "") -> Int32 {
        
        var text = self
        if !removeText.isEmpty {
            text = self.replacingOccurrences(of: removeText, with: "")
        }
        
        if text.last == "万" {
            return Int32(Double(text.replacingOccurrences(of: "万", with: ""))! * 10000)
        } else if text.last == "亿" {
            return Int32(Double(text.replacingOccurrences(of: "亿", with: ""))! * 100000000)
        }
        
        return Int32(text) ?? -1
    }
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var releaseVersionNumberaPretty: String {
        return "v\(releaseVersionNumber ?? "1.0.0").0"
    }
}

extension BiliBili.CardElement {
    func toVideoState() -> VideoState {
        let cardDetail = self.card.toDynamicCardDetail()
        return cardDetail.toVideoState()
    }
}

extension BiliBili.CardDetail {
    func toVideoState() -> VideoState {
        let avatar = self.owner.face.resizeImage(w: 60, h: 60)
        let upName = self.owner.name
        let upId = String(self.owner.mid)
        let playCount = self.stat["view"]
        let danmuCount = self.stat["danmaku"]
        let cover = self.pic.resizeImage(w: 240, h: 160)
        let title = self.title
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "MM-dd HH:mm"
        let label = formatter.string(from: Date(timeIntervalSince1970: Double(self.pubdate)))
        let link = self.short_link_v2
        
        return VideoState(upAvatar: avatar, upName: upName, upId: upId, label: label, cover: cover, title: title, playCount: Int32(playCount!), danmuCount: Int32(danmuCount!), id: String(self.aid), videoId: String(self.aid), link: link)
    }
}

extension Mine {
    func assignAccountState( state: inout AccountState, unreadCount: Int32?) {
        let image = self.face.resizeImage(w: 90, h: 90)
        state.avatar = URL(string: image)
        state.userName = self.name
        state.userId = String(self.mid)
        state.level = self.level
        state.coinNumber = self.coin
        state.bcoinNumber = self.bcoin
        state.followingNumber = self.following
        state.fansNumber = self.follower
        state.dynamicNumber = self.dynamic
        state.followingLink = "https://space.bilibili.com/\(state.userId)/fans/follow"
        state.fansLink = "https://space.bilibili.com/\(state.userId)/fans/fans"
        state.dynamicLink = "https://space.bilibili.com/\(state.userId)/dynamic"
        state.messageNumber = unreadCount!
    }
}

extension UnreadInfo {
    func total() -> Int32 {
        return self.at + self.chat + self.like + self.reply
    }
}

extension BiliBili.Episode {
    func toEpisodeState() -> EpisodeState {
        let id = String(self.episode_id)
        let cover = self.square_cover.resizeImage(w: 120, h: 120)
        let title = self.title
        let label = self.pub_index
        let seasonId = String(self.season_id)
        let publishTime = self.pub_time
        let seasonCover = self.cover
        
        return EpisodeState(id: id, cover: cover, title: title, label: label, seasonId: seasonId, publishTime: publishTime, seasonCover: seasonCover)
    }
}

extension SearchRecommentItem {
    func toHotItemState() -> HotSearchItemState {
        let title = self.show_name ?? ""
        let keyword = self.keyword ?? ""
        let icon = self.icon?.resizeImage(w: 40, h: 40) ?? ""
        let index = String(self.position!)
        let isShowIcon = !icon.isEmpty
        
        return HotSearchItemState(title: title, icon: icon, isShowIcon: isShowIcon, id: index, keyword: keyword)
    }
}

extension Bilibili_App_Card_V1_Card {
    func toVideoState() -> VideoState {
        let v5 = self.smallCoverV5
        let card = v5.base
        let shareInfo = card.threePointV4.sharePlane
        let title = card.title
        let id = String(shareInfo.aid)
        let bvId = shareInfo.bvid
        let upName = shareInfo.author
        let upId = String(shareInfo.authorID)
        let link = shareInfo.shortLink
        let cover = card.cover.resizeImage(w: 240, h: 160)
        let playCount = shareInfo.playNumber.toCountNumber(removeText: "次")
        let descSplit = v5.rightDesc2.split(separator: "·")
        var label = upName
        if descSplit.count > 1 {
            let timeText = descSplit[1].replacingOccurrences(of: " ", with: "")
            label += " · \(timeText)"
        }
        let duration = v5.coverRightText1
        
        return VideoState(upAvatar: "", upName: upName, upId: upId, label: label, cover: cover, title: title, playCount: playCount, danmuCount: -1, id: bvId, videoId: id, link: link, duration: duration)
    }
}
