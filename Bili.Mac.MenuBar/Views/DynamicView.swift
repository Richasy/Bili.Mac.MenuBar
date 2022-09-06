//
//  DynamicView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/5.
//

import SwiftUI
import ComposableArchitecture

struct DynamicView: View {
    
    let store: Store<DynamicState, DynamicAction>
    
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
                    List(viewStore.videos ?? [VideoState]()) { video in
                        VideoCard(store: Store(initialState: video, reducer: videoReducer, environment: ()))
                            .listRowInsets(EdgeInsets(top: 8, leading: 12, bottom: 4, trailing: 0))
                    }
                    .listStyle(.plain)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .onAppear {
                viewStore.send(DynamicAction.request)
            }
        }
    }
}

struct DynamicView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicView(store: Store(initialState: .init(isLoading: false), reducer: dynamicReducer, environment: .init()))
    }
}
