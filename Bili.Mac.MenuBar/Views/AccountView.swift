//
//  AccountView.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/5.
//

import SwiftUI
import ComposableArchitecture

struct AccountView: View {
    
    let store: Store<AccountState, AccountAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                HStack (spacing: 12) {
                    AsyncImage(url: viewStore.avatar) { image in
                        image.resizable()
                            .cornerRadius(24)
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 48, height: 48, alignment: .center)
                    VStack {
                        HStack (spacing: 10) {
                            Text(viewStore.userName)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .lineLimit(1)
                            
                            SwiftUI.Image("Level_\(viewStore.level)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 24, alignment: .leading)
                        }.frame(maxWidth:.infinity, alignment:.leading)
                        
                        Text("硬币: \(viewStore.coinNumber, specifier: "%.1f")  |  B币: \(viewStore.bcoinNumber, specifier: "%.0f")")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .frame(maxWidth:.infinity, alignment:.leading)
                    }
                    
                    Spacer()
                    
                    Button {
                        viewStore.send(AccountAction.openSpace)
                    } label: {
                        ZStack {
                            SwiftUI.Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 14, alignment: .center)
                        }
                        .frame(width: 36, height: 36, alignment: .center)
                        .background(Color("ButtonBackground"))
                        .cornerRadius(16)
                    }
                    .buttonStyle(.plain)
                    .help("打开个人主页")
                    
                }
                .padding(EdgeInsets(top: 12, leading: 28, bottom: 10, trailing: 28))
                
                HStack(spacing: 6) {
                    ModuleButton(url: viewStore.binding(\.$followingLink), count: viewStore.binding(\.$followingNumber), text: "关注")
                    ModuleButton(url: viewStore.binding(\.$fansLink), count: viewStore.binding(\.$fansNumber), text: "粉丝")
                    ModuleButton(url: viewStore.binding(\.$dynamicLink), count: viewStore.binding(\.$dynamicNumber), text: "动态")
                    ModuleButton(url: viewStore.binding(\.$messageLink), count: viewStore.binding(\.$messageNumber), text: "消息")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                viewStore.send(AccountAction.request)
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(store: Store(initialState: .init(), reducer: accountReducer, environment: .init()))
    }
}
