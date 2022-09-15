//
//  EpisodeCard.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/6.
//

import SwiftUI
import ComposableArchitecture

struct EpisodeCard: View {
    
    let store: Store<EpisodeState, EpisodeAction>
    @State var isHovering: Bool = false
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Button (action: {
                viewStore.send(.click)
            }) {
                HStack(spacing: 12) {
                    AsyncImage(url: URL(string: viewStore.cover)) { image in
                        image.resizable()
                            .cornerRadius(4)
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }.frame(width: 96, height: 96, alignment: .center)
                    
                    VStack(spacing: 4) {
                        Text(viewStore.title)
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .lineLimit(2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .help(viewStore.title)
                        Text("\(viewStore.publishTime) 发布")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Group {
                            Text("更新至 ") +
                            Text(viewStore.label)
                                .foregroundColor(.accentColor)
                        }.frame(maxWidth:.infinity, alignment:.leading)
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
                    viewStore.send(.copyCoverLink)
                } label: {
                    Text("复制剧集封面链接")
                }
            }
            .frame(height: 125, alignment: .top)
            .frame(maxWidth: .infinity)
        }
    }
}
