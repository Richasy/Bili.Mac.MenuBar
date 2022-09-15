//
//  HotSearchItem.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/10.
//

import SwiftUI
import ComposableArchitecture

struct HotSearchItem: View {
    
    let store: Store<HotSearchItemState, HotSearchItemAction>
    @State var isHovering: Bool = false
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Button {
                viewStore.send(.open)
            } label: {
                HStack {
                    Text(viewStore.id)
                        .frame(alignment: .center)
                        .foregroundColor(.secondary)
                        .padding()
                    if viewStore.isShowIcon {
                        AsyncImage(url: URL(string: viewStore.icon)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 12, height: 12, alignment: .center)
                        }
                        .frame(width: 16, height: 16, alignment: .center)
                        .padding([.trailing], 4)
                    }
                    Text(viewStore.title)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .frame(maxWidth:.infinity, alignment:.leading)
                        .help(viewStore.keyword)
                }
                .frame(maxWidth:.infinity, maxHeight:.infinity)
                .background(isHovering ? Color("ButtonBackground") : nil)
                .cornerRadius(4)
            }
            .onHover(perform: { isHovering in
                self.isHovering = isHovering
            })
            .buttonStyle(.plain)
            .frame(
                maxHeight: .infinity)
            .animation(.linear(duration: 0.2), value: isHovering)
        }
    }
}

struct HotSearchItem_Previews: PreviewProvider {
    static var previews: some View {
        HotSearchItem(store: Store(initialState: HotSearchItemState(title: "测试条目", icon: "", isShowIcon: false, id: "1", keyword: "haha"), reducer: hotSearchItemReducer, environment: ()))
            .frame(width: 300, height: 40, alignment: .center)
    }
}
