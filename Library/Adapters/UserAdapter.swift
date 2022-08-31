//
//  UserAdapter.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

class UserAdapter: UserAdapterProtocol {
    private let imageAdapter: ImageAdapterProtocol
    
    init(imageAdapter: ImageAdapterProtocol){
        self.imageAdapter = imageAdapter;
    }
    
    func convertToUserProfile(userId: Int64, userName: String, avatar: String, size: Double) -> UserProfile {
        let image = avatar.isEmpty ? nil : imageAdapter.ConvertToImage(uri: avatar, width: size, height: size)
        let profile = UserProfile(id: String(userId), name: userName, avatar: image)
        return profile
    }
}
