//
//  RankView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/6.
//

import SwiftUI
import ComposableArchitecture

struct RankView: View {
    let store: Store<RankState, RankAction>
    
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
                } else if viewStore.videos != nil {
                    Text("根据稿件内容质量、近期的数据综合展示，动态更新")
                        .padding(EdgeInsets(top: 20, leading: 24, bottom: 8, trailing: 12))
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    List(viewStore.videos ?? [VideoState]()) { video in
                        VideoCard(store: Store(initialState: video, reducer: videoReducer, environment: ()))
                            .listRowInsets(EdgeInsets(top: 8, leading: 14, bottom: 4, trailing: 0))
                    }
                    .listStyle(.plain)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("数据获取失败，请稍后重试")
                        .foregroundColor(.secondary)
                }
            }
            .onAppear {
                viewStore.send(RankAction.request)
            }
        }
    }
}

struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView(store: Store(initialState: .init(isLoading: false), reducer: rankReducer, environment: .init()))
    }
}
