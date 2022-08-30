//
//  ContentView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Button(action: {}) {
                Text("Hello, world!")
                    .padding()
            }
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
