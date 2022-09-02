//
//  QRCodeStateChangedEventArgs.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/31.
//

import Foundation

struct QRCodeStateChangedEventArgs {
    let state: QRCodeState
    let token: TokenInfo?
}
