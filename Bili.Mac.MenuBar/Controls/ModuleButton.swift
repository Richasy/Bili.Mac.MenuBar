//
//  ModuleButton.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/9/4.
//

import SwiftUI

struct ModuleButton: View {
    
    @Environment(\.openURL) private var openURL
    
    @Binding var url: String
    @Binding var count: Int32
    @State var text: String = ""
    @State var isHovering: Bool = false
    
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
            .background(isHovering ? Color( "ButtonBackground") : nil)
            .cornerRadius(8)
            .animation(.linear(duration: 0.2), value: isHovering)
        }
        .buttonStyle(.plain)
        .onHover { isHovering in
            self.isHovering = isHovering
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
