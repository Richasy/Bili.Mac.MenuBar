//
//  DynamicCard.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/4.
//

import SwiftUI
import ComposableArchitecture

struct VideoCard: View {
    
    let store: Store<VideoState, VideoAction>
    @State var isHovering: Bool = false
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Button (action: {
                viewStore.send(.click)
            }) {
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: viewStore.upAvatar)) { image in
                            image.resizable()
                                .cornerRadius(16)
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }.frame(width: 32, height: 32, alignment: .center)
                        
                        VStack(spacing: 2) {
                            Text(viewStore.upName)
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                .frame(maxWidth:.infinity, alignment:.leading)
                            Text(viewStore.label)
                                .font(.system(size: 10, weight: .regular, design: .rounded))
                                .foregroundColor(.secondary)
                                .frame(maxWidth:.infinity, alignment:.leading)
                        }.frame(maxWidth:.infinity, alignment:.leading)
                    }
                    
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: viewStore.cover)) { image in
                            image.resizable()
                                .cornerRadius(4)
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }.frame(width: 120, height: 82, alignment: .center)
                        
                        VStack {
                            Text(viewStore.title)
                                .font(.system(size: 14, weight: .regular, design: .rounded))
                                .lineLimit(2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .help(viewStore.title)
                            Spacer()
                            HStack(spacing: 20) {
                                HStack(spacing: 4) {
                                    SwiftUI.Image(systemName: "play.circle.fill")
                                        .frame(width: 14, height: 14, alignment: .center)
                                        .foregroundColor(.secondary)
                                    Text(convertNumber(num: viewStore.playCount))
                                        .font(.system(size: 12, weight: .regular, design: .rounded))
                                        .foregroundColor(.secondary)
                                }
                                .help("播放量")
                                HStack(spacing: 4) {
                                    SwiftUI.Image(systemName: "list.bullet.indent")
                                        .frame(width: 14, height: 14, alignment: .center)
                                        .foregroundColor(.secondary)
                                    Text(convertNumber(num: viewStore.danmuCount))
                                        .font(.system(size: 12, weight: .regular, design: .rounded))
                                        .foregroundColor(.secondary)
                                }
                                .help("弹幕数")
                            }.frame(maxWidth:.infinity, alignment:.leading)
                        }
                    }
                }
                .frame(maxWidth:.infinity, maxHeight: .infinity)
                .padding()
                .background(isHovering ? Color("ButtonBackground") : nil)
                .cornerRadius(8)
                .animation(.linear(duration:0.2), value: isHovering)
            }
            .buttonStyle(.plain)
            .onHover(perform: { isHovering in
                self.isHovering = isHovering
            })
            .contextMenu {
                Button {
                    viewStore.send(.click)
                } label: {
                    Text("打开")
                }
                
                Button {
                    viewStore.send(.copyLink)
                } label: {
                    Text("复制链接")
                }
                
                Button {
                    viewStore.send(.openUpSpace)
                } label: {
                    Text("打开 UP 主页")
                }
            }
            .frame(height: 158, alignment: .top)
            .frame(maxWidth: .infinity)
        }
    }
    
    private func convertNumber(num: Int32) -> String {
        switch num {
        case 0..<10000:
            return String(num)
        default:
            return String(format:"%.1f", Double(num) / 10000.0) + "万"
        }
    }
}
