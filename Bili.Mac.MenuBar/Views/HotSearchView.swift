//
//  HotSearchView.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/10.
//

import SwiftUI
import ComposableArchitecture

struct HotSearchView: View {
    
    let store: Store<HotSearchState, HotSearchAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                if viewStore.isLoading {
                    HStack(spacing: 8) {
                        ProgressView()
                        Text("加载中...")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else if viewStore.list != nil {
                    Text("B站热搜榜，实时更新")
                        .padding(EdgeInsets(top: 20, leading: 24, bottom: 8, trailing: 12))
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    List(viewStore.list ?? [HotSearchItemState]()) { item in
                        HotSearchItem(store: Store(initialState: item, reducer: hotSearchItemReducer, environment: ()))
                            .listRowInsets(EdgeInsets(top: 4, leading: 14, bottom: 4, trailing: 0))
                    }
                    .listStyle(.plain)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("数据获取失败，请稍后重试")
                        .foregroundColor(.secondary)
                }
            }
            .onAppear {
                viewStore.send(.request)
            }
        }
    }
}

struct HotSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HotSearchView(store: Store(initialState: .init(isLoading: false), reducer: hotSearchReducer, environment: .init()))
    }
}
