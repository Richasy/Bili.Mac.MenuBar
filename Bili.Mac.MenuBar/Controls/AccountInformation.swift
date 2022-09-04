//
//  AccountInformation.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/3.
//

import SwiftUI
import GRPC

struct AccountInformation: View {
    
    init() {
        accountProvider = DIFactory.instance.container.resolve(AccountProviderProtocol.self)!
        imageAdapter = DIFactory.instance.container.resolve(ImageAdapterProtocol.self)!
    }
    
    private let accountProvider: AccountProviderProtocol
    private let imageAdapter: ImageAdapterProtocol
    
    @State var avatar: URL? = nil
    @State var userName: String = "--"
    @State var level: Int16 = 0
    @State var coinNumber: Double = 0.0
    @State var bcoinNumber: Double = 0.0
    @State var userId: String = ""
    @State var followingNumber: Int32 = 0
    @State var fansNumber: Int32 = 0
    @State var dynamicNumber: Int32 = 0
    @State var messageNumber: Int32 = 0
    @State var followingLink: String = ""
    @State var fansLink: String = ""
    @State var dynamicLink: String = ""
    @State var messageLink: String = "https://message.bilibili.com/"
    
    var body: some View {
        VStack {
            HStack (spacing: 12) {
                AsyncImage(url: avatar) { image in
                    image.resizable()
                        .cornerRadius(24)
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 48, height: 48, alignment: .center)
                VStack {
                    HStack (spacing: 10) {
                        Text(userName)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .lineLimit(1)
                            
                        SwiftUI.Image("Level_\(level)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 24, alignment: .leading)
                    }.frame(maxWidth:.infinity, alignment:.leading)
                    
                    Text("硬币: \(coinNumber, specifier: "%.1f")  |  B币: \(bcoinNumber, specifier: "%.0f")")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .frame(maxWidth:.infinity, alignment:.leading)
                }
                
                Spacer()
                
                Button(action: {
                    DIFactory.instance.container.resolve(AuthorizeProviderProtocol.self)!.signOut()
                }) {
                    ZStack {
                        SwiftUI.Image(systemName: "line.3.horizontal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, alignment: .center)
                    }
                    .frame(width: 36, height: 36, alignment: .center)
                    .background(Color("ButtonBackground"))
                    .cornerRadius(16)
                }
                .buttonStyle(.plain)
            }
            .padding(EdgeInsets(top: 12, leading: 28, bottom: 10, trailing: 28))
            
            HStack(spacing: 6) {
                ModuleButton(url: $followingLink, count: $followingNumber, text: "关注")
                ModuleButton(url: $fansLink, count: $fansNumber, text: "粉丝")
                ModuleButton(url: $dynamicLink, count: $dynamicNumber, text: "动态")
                ModuleButton(url: $messageLink, count: $messageNumber, text: "消息")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            accountProvider.events.addEvent(id: "AccountInformation", name: EventKeys.accountUpdated.rawValue) { data in
                loadMine(mine: data as? Mine)
            }
            
            accountProvider.events.addEvent(id: "AccountInformation", name: EventKeys.messageCountUpdated.rawValue) { data in
                guard let info = data as? UnreadInfo else {
                    return
                }
                
                messageNumber = info.at + info.chat + info.like + info.reply
            }
            
            Task {
                let _ = await accountProvider.getMyInformationAsync()
                let _ = await accountProvider.getUnreadMessageAsync()
            }
        }
        .onDisappear {
            accountProvider.events.removeEvent(id: "AccountInformation", name: EventKeys.accountUpdated.rawValue)
            accountProvider.events.removeEvent(id: "AccountInformation", name: EventKeys.messageCountUpdated.rawValue)
        }
    }
    
    private func loadMine(mine: Mine?) {
        guard let mine = mine else {
            return
        }
        
        let image = imageAdapter.ConvertToImage(uri: mine.face, width: 90, height: 90)
        avatar = URL(string: image.uri.replacingOccurrences(of: "http:", with: "https:"))
        userName = mine.name
        userId = String(mine.mid)
        level = mine.level
        coinNumber = mine.coin
        bcoinNumber = mine.bcoin
        followingNumber = mine.following
        fansNumber = mine.follower
        dynamicNumber = mine.dynamic
        followingLink = "https://space.bilibili.com/\(userId)/fans/follow"
        fansLink = "https://space.bilibili.com/\(userId)/fans/fans"
        dynamicLink = "https://space.bilibili.com/\(userId)/dynamic"
    }
}

struct AccountInformation_Previews: PreviewProvider {
    static var previews: some View {
        AccountInformation()
            .frame(width: 340, height: 115, alignment: .center)
    }
}
