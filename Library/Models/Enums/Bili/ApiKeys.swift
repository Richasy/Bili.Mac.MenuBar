//
//  ApiKeys.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/1.
//

import Foundation

enum ApiKeys: String {
    case checkToken = "https://passport.bilibili.com/api/oauth2/info"
    case tokenInfo = "https://passport.bilibili.com/x/passport-login/oauth2/info"
    case sso = "https://passport.bilibili.com/api/login/sso"
    case qrCode = "https://passport.bilibili.com/x/passport-tv-login/qrcode/auth_code"
    case qrCodeCheck = "https://passport.bilibili.com/x/passport-tv-login/qrcode/poll"
    case refreshToken = "https://passport.bilibili.com/api/oauth2/refreshToken"
    
    case myInfo = "https://app.bilibili.com/x/v2/account/myinfo"
    case mine = "https://app.bilibili.com/x/v2/account/mine"
    case message = "https://api.bilibili.com/x/msgfeed/unread"
    
    case dynamic = "https://api.vc.bilibili.com/dynamic_svr/v1/dynamic_svr/dynamic_new"
    case rank = "https://api.bilibili.com/x/web-interface/ranking/v2"
}
