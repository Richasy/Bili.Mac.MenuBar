//
//  GRPCConfig.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/15.
//

import Foundation

struct GRPCConfig {
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    let osVersion = "14.6"
    let brand = "Apple"
    let model = "iPhone 11"
    let appVersion = "6.7.0"
    let build: Int32 = 6070600
    let channel = "bilibili140"
    let networkType = 2
    let networkTF = 0
    let networdOid = "46007"
    let cronet = "1.21.0"
    let buvid = "XZFD48CFF1E68E637D0DF11A562468A8DC314"
    let mobileApp = "iphone"
    let plaform = "iphone"
    let enviroment = "prod"
    let appId: Int32 = 1
    let region = "cn"
    let language = "zh"
    
    var accessToken: String
    
    func getFawkesReqBin() -> String {
        var msg = Bilibili_Metadata_Fawkes_FawkesReq()
        msg.appkey = self.mobileApp
        msg.env = self.enviroment
        return try! msg.serializedData().toBase64String()
    }
    
    func getMetadataBin() -> String {
        var msg = Bilibili_Metadata_Metadata()
        msg.accessKey = self.accessToken
        msg.mobiApp = self.mobileApp
        msg.build = self.build
        msg.channel = self.channel
        msg.buvid = self.buvid
        msg.platform = self.plaform
        return try! msg.serializedData().toBase64String()
    }
    
    func getDeviceBin() -> String {
        var msg = Bilibili_Metadata_Device_Device()
        msg.appID = self.appId
        msg.mobiApp = self.mobileApp
        msg.build = self.build
        msg.channel = self.channel
        msg.buvid = self.buvid
        msg.platform = self.plaform
        msg.brand = self.brand
        msg.model = self.model
        msg.osver = self.osVersion
        return try! msg.serializedData().toBase64String()
    }
    
    func getNetworkBin() -> String {
        var msg = Bilibili_Metadata_Network_Network()
        msg.type = .wifi
        msg.oid = self.networdOid
        return try! msg.serializedData().toBase64String()
    }
    
    func getRestrictionBin() -> String {
        let msg = Bilibili_Metadata_Restriction_Restriction()
        return try! msg.serializedData().toBase64String()
    }
    
    func getLocaleBin() -> String {
        var msg = Bilibili_Metadata_Locale_Locale()
        msg.cLocale = Bilibili_Metadata_Locale_LocaleIds()
        msg.sLocale = Bilibili_Metadata_Locale_LocaleIds()
        msg.cLocale.language = self.language
        msg.cLocale.region = self.region
        msg.sLocale.language = self.language
        msg.sLocale.region = self.region
        return try! msg.serializedData().toBase64String()
    }
}

extension Data {
    func toBase64String() -> String {
        return self.base64EncodedString().replacingOccurrences(of: "=+$", with: "", options: .regularExpression)
    }
}
