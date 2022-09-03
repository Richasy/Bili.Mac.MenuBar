//
//  AppLogo.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/2.
//

import SwiftUI

struct AppLogo: View {
    var body: some View {
        VStack (spacing: 24) {
            HStack(spacing: 14) {
                SwiftUI.Image("AppIconWithoutBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 52, height: 52, alignment: .center)
                
                Text("迷你哔哩")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
            }
            
            Text("随时查看你订阅的 BiliBili 视频更新")
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundColor(.secondary)
        }
    }
}

struct AppLogo_Previews: PreviewProvider {
    static var previews: some View {
        AppLogo()
    }
}
