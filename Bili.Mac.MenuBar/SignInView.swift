//
//  SignInView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/2.
//

import SwiftUI

struct SignInView: View {
    
    @State var isShowQRCode = false
    @State var logoTopPadding: Double = 100
    
    var body: some View {
        VStack {
            AppLogo()
                .padding([.top], logoTopPadding)
            
            if !isShowQRCode {
                Spacer()
                Button (action: {
                    isShowQRCode = true
                    logoTopPadding = 46
                }) {
                    Text("扫码登录")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("ButtonBackground"))
                        .cornerRadius(26)
                        .padding(EdgeInsets(top: 0, leading: 40, bottom: 64, trailing: 40))
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.plain)
                
            } else {
                SignInQRCode()
                    .padding([.top], 45)
                Spacer()
            }
            
            Group {
                Text("不主动") +
                Text("更新").foregroundColor(.secondary) +
                Text("  |  不拒绝") +
                Text("使用").foregroundColor(.secondary) +
                Text("  |  不负责") +
                Text("维护").foregroundColor(.secondary)
            }.padding([.bottom], 24)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .frame(width: 400, height: 600, alignment: .center)
    }
}
