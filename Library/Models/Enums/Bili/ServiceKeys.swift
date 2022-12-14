//
//  ServiceKeys.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/8/31.
//

enum ServiceKeys : String {
    case acceptString = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
    case userAgent = "bili-universal/68800100 Darwin/21.6.0 os/ios model/iPhone 11 mobi_app/iphone build/68800100 osVer/15.6.1 network/2 channel/AppStore"
    case webAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36 Edg/92.0.902.62"
    case buildNumber = "68800100"
    
    case contentType = "Content-Type"
    case identify = "identify_v1"
    case gRPCContentType = "application/grpc"
    case referer = "Referer"
    case appKey = "APP-KEY"
    case biliMeta = "x-bili-metadata-bin"
    case authorization = "authorization"
    case biliDevice = "x-bili-device-bin"
    case biliNetwork = "x-bili-network-bin"
    case biliRestriction = "x-bili-restriction-bin"
    case biliLocale = "x-bili-locale-bin"
    case biliFawkes = "x-bili-fawkes-req-bin"
    case gRPCAcceptEncodingKey = "grpc-accept-encoding"
    case gRPCAcceptEncodingValue = "identity,deflate,gzip"
    case gRPCTimeOutKey = "grpc-timeout"
    case gRPCTimeOutValue = "20100m"
    case envoriment = "env"
    case transferEncodingKey = "Transfer-Encoding"
    case transferEncodingValue = "chunked"
    case teKey = "TE"
    case teValue = "trailers"
}
