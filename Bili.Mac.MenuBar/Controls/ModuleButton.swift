//
//  ModuleButton.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/4.
//

import SwiftUI

struct ModuleButton: View {
    
    @Environment(\.openURL) private var openURL
    
    @Binding var url: String
    @Binding var count: Int32
    @State var text: String = ""
    
    var body: some View {
        Button {
            if let uri = URL(string: url) {
                openURL(uri)
            }
        } label: {
            VStack(spacing: 4) {
                Text(convertNumber(num: count))
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                Text(text)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary)
            }
            .frame(width: 80, height: 55, alignment: .center)
            .background(Color("ButtonBackground"))
            .cornerRadius(8)
        }.buttonStyle(.plain)
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
