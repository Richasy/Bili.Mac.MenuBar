//
//  PlayerView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/16.
//

import SwiftUI

struct PlayerView: View {
    
    @State var url = ""
    @State var shouldShown = true
    
    var body: some View {
        WebView(url: $url)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.red)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
