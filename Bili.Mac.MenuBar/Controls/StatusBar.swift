//
//  StatusBar.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/6.
//

import SwiftUI
import ComposableArchitecture

struct StatusBar: View {
    
    let store: Store<AppState, AppAction>
    @State var isPageButtonHover: Bool = false
    @State var isSettingButtonHover: Bool = false
    
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                Menu {
                    
                } label: {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                }
                .menuStyle(BorderlessButtonMenuStyle())
                .frame(width: 32, height: 16)
                .padding(3)
                .background(isPageButtonHover ? Color("ButtonBackgroundHover") : nil)
                .cornerRadius(4)
                .onHover { isHovered in
                    isPageButtonHover = isHovered
                }
                .help("切换页面")
                
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
                    }
                    .disabled(false)
                    
                    VStack {
                        Divider()
                    }
                    
                    Button {
                        viewStore.send(AppAction.signOut)
                    } label: {
                        Text("登出账户")
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
    }
}
