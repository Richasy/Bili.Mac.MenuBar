//
//  DynamicCard.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/4.
//

import SwiftUI

struct DynamicCard: View {
    
    @State var info: DynamicInfo
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        Button (action: {
            openURL(URL(string: info.link)!)
        }) {
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    AsyncImage(url: URL(string: info.upAvatar.replacingOccurrences(of: "http:", with: "https:"))) { image in
                        image.resizable()
                            .cornerRadius(16)
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }.frame(width: 32, height: 32, alignment: .center)
                    
                    VStack(spacing: 2) {
                        Text(info.upName)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .frame(maxWidth:.infinity, alignment:.leading)
                        Text(info.label)
                            .font(.system(size: 10, weight: .regular, design: .rounded))
                            .foregroundColor(.secondary)
                            .frame(maxWidth:.infinity, alignment:.leading)
                    }.frame(maxWidth:.infinity, alignment:.leading)
                }
                
                HStack(spacing: 12) {
                    AsyncImage(url: URL(string: info.cover)) { image in
                        image.resizable()
                            .cornerRadius(4)
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }.frame(width: 120, height: 82, alignment: .center)
                    
                    VStack {
                        Text(info.title)
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .lineLimit(2)
                        Spacer()
                        HStack(spacing: 20) {
                            HStack(spacing: 4) {
                                SwiftUI.Image(systemName: "play.circle.fill")
                                    .frame(width: 14, height: 14, alignment: .center)
                                    .foregroundColor(.secondary)
                                Text(convertNumber(num: info.playCount))
                                    .font(.system(size: 12, weight: .regular, design: .rounded))
                                    .foregroundColor(.secondary)
                            }
                            HStack(spacing: 4) {
                                SwiftUI.Image(systemName: "list.bullet.indent")
                                    .frame(width: 14, height: 14, alignment: .center)
                                    .foregroundColor(.secondary)
                                Text(convertNumber(num: info.danmuCount))
                                    .font(.system(size: 12, weight: .regular, design: .rounded))
                                    .foregroundColor(.secondary)
                            }
                        }.frame(maxWidth:.infinity, alignment:.leading)
                    }
                }
            }
            .frame(maxWidth:.infinity, maxHeight: .infinity)
            .padding()
            .background(Color("ButtonBackground"))
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
        .frame(height: 158, alignment: .top)
        .frame(maxWidth: .infinity)
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
