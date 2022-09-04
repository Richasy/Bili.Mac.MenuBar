//
//  ImageAdapter.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

class ImageAdapter: ImageAdapterProtocol {
    
    func ConvertToImage(uri: String) -> Image {
        Image(uri: uri)
    }
    
    func ConvertToImage(uri: String, width: Double, height: Double) -> Image {
        Image(uri: uri, width: width, height: height) {(w,h) in
                return "@\(Int(w))w_\(Int(h))h_1c_100q.jpg"
        }
    }
}
