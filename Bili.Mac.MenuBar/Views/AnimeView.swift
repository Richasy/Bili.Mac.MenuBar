//
//  AnimeView.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/6.
//

import SwiftUI
import ComposableArchitecture

struct AnimeView: View {
    let store: Store<AnimeState, AnimeAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                if viewStore.isLoading {
                    HStack(spacing: 8) {
                        ProgressView()
                        Text("加载中...")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else if viewStore.episodes != nil {
                    if viewStore.episodes!.count == 0 {
                        Text("看上去今天没有动漫更新")
                            .foregroundColor(.secondary)
                    } else {
                        Text("只显示今天更新的动漫，按照更新时间排序")
                            .padding(EdgeInsets(top: 20, leading: 24, bottom: 8, trailing: 12))
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        List(viewStore.episodes ?? [EpisodeState]()) { ep in
                            EpisodeCard(store: Store(initialState: ep, reducer: episodeReducer, environment: ()))
                                .listRowInsets(EdgeInsets(top: 8, leading: 14, bottom: 4, trailing: 0))
                        }
                        .listStyle(.plain)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                } else {
                    Text("数据获取失败，请稍后重试")
                        .foregroundColor(.secondary)
                }
            }
            .onAppear {
                viewStore.send(AnimeAction.request)
            }
        }
    }
}

struct AnimeView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeView(store: Store(initialState: .init(isLoading: false), reducer: animeReducer, environment: .init()))
    }
}
