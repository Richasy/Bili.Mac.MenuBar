//
//  AccountView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/3.
//

import SwiftUI

struct AccountView: View {
    
    @State var cards: [DynamicInfo]? = nil
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack(alignment:.leading) {
            AccountInformation()
                .frame(maxWidth: .infinity, maxHeight: 150, alignment: .top)
            if isLoading {
                HStack(spacing: 8) {
                    ProgressView()
                    Text("加载中...")
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else if cards != nil {
                List(cards ?? [DynamicInfo]()) { card in
                    DynamicCard(info: card)
                        .listRowInsets(EdgeInsets(top: 8, leading: 12, bottom: 4, trailing: 0))
                }
                .listStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            Task {
                isLoading = true
                cards  = await DIFactory.instance.container.resolve(CommunityProviderProtocol.self)!.getDynamicVideoListAsync()
                isLoading = false
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .frame(width: 400, height: 600, alignment: .center)
    }
}
