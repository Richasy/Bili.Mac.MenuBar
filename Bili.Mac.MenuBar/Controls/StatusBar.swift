//
//  StatusBar.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/6.
//

import SwiftUI
import ComposableArchitecture

struct StatusBar: View {
    
    let store: Store<AppState, AppAction>
    @State var isSettingButtonHover: Bool = false
    
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                Picker(selection: viewStore.binding(\.$currentPage)) {
                    Text("主页").tag(PageKeys.subscribe)
                    Text("排行榜").tag(PageKeys.rank)
                    Text("今日动漫").tag(PageKeys.todayAnime)
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
                .frame(width: 120, alignment: .center)
                .padding(3)
                .cornerRadius(4)
                .onChange(of: viewStore.currentPage, perform: { _ in
                    viewStore.send(AppAction.saveCurrentPage)
                }).help("切换页面")
                
                Spacer()
                
                Menu {
                    
                    if !viewStore.autoRefresh {
                        Button {
                            viewStore.send(AppAction.refresh)
                        } label: {
                            Text("刷新")
                        }
                    }
                    
                    Button {
                        return
                    } label: {
                        Picker("自动刷新", selection: viewStore.binding(\.$autoRefresh)) {
                            Text("开启").tag(true)
                            Text("关闭").tag(false)
                        }
                        .onChange(of: viewStore.autoRefresh, perform: { _ in
                            viewStore.send(AppAction.saveAutoRefresh)
                        })
                    }
                    
                    VStack {
                        Divider()
                    }
                    
                    Button {
                        viewStore.send(AppAction.authorize(.signOut))
                    } label: {
                        Text("退出账户")
                    }
                    
                    VStack {
                        Divider()
                    }
                    
                    Button {
                        viewStore.send(AppAction.exit)
                    } label: {
                        Text("关闭应用")
                    }
                    
                } label: {
                    Image(systemName: "gear")
                }
                .menuStyle(BorderlessButtonMenuStyle())
                .frame(width: 32, height: 16)
                .padding(3)
                .background(isSettingButtonHover ? Color("ButtonBackgroundHover") : nil)
                .cornerRadius(4)
                .onHover { isHovered in
                    isSettingButtonHover = isHovered
                }
                .animation(.linear(duration: 0.2), value: isSettingButtonHover)
                .help("选项与设置")
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 10)
            .padding(.horizontal, 10)
        }
    }
}

struct StatusBar_Previews: PreviewProvider {
    static var previews: some View {
        StatusBar(store: Store(initialState: .init(), reducer: appReducer, environment: ()))
            .frame(width: 400, height: 40, alignment: .center)
    }
}
