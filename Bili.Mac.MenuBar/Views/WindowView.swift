//
//  WindowView.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/4.
//

import SwiftUI

struct WindowView: View {
    
    @State var versionNumber: String = ""
    
    var body: some View {
        VStack {
            SwiftUI.Image("SimpleIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120, alignment: .center)
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            
            VStack(spacing: 8) {
                Text("迷你哔哩")
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                Text("版本 \(versionNumber)")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                Text("将哔哩放在菜单栏，随时查看视频更新")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(spacing: 8) {
                Text("开发者语")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                Text("买了台 Mac 毕竟不能闲置，总是要开发点什么来自娱自乐的，哔哩对我来说总是练手的首选，写几个小工具，SwiftUI 差不多就上手了")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .frame(width: 320, alignment: .center)
            }
            .padding()
        }
        .frame(width: 400, height: 400, alignment: .top)
        .onAppear{
            versionNumber = Bundle.main.releaseVersionNumberaPretty
        }
    }
}

struct WindowView_Previews: PreviewProvider {
    static var previews: some View {
        WindowView()
    }
}
