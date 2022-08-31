//
//  ContentView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/30.
//

import SwiftUI

struct ContentView: View {
    
    let imageAdapter = DIFactory.instance.container.resolve(ImageAdapterProtocol.self)
    
    @State var text = "Hello World"
    
    var body: some View {
        VStack{
            Button(action: {
                text = imageAdapter?.ConvertToImage(uri: "https://www.baidu.com", width: 200, height: 200).uri ?? "None"
            }) {
                Text(text)
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
