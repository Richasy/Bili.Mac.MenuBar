//
//  ContentView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/30.
//

import SwiftUI
import QRCodeGenerator
import SVGView
import NIOHTTP2

struct ContentView: View {
    
    let imageAdapter = DIFactory.instance.container.resolve(ImageAdapterProtocol.self)
    let httpProvider = DIFactory.instance.container.resolve(HttpProviderProtocol.self)
    
    @State var image: URL? = nil
    
    var body: some View {
        VStack{
            Button(action: {
                /*
                if image == nil {
                    let qr = try! QRCode.encode(text: "https://www.baidu.com", ecl: .medium)
                    let svg = qr.toSVGString(border: 2)
                    var url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
                    url.appendPathComponent("bili_signin_qrcode.svg")
                    if let data = svg.data(using: .utf8) {
                        try? data.write(to: url)
                        image = url
                    }
                }
                else {
                    try? FileManager.default.removeItem(atPath: image?.path ?? "")
                    image = nil
                } */
                
                let url = "https://jsonplaceholder.typicode.com/posts"
                
                Task {
                    let request = await httpProvider?.getRequestMessageAsync(method: "GET", url: url, queryParams: Dictionary<String, String>(), type: .ios, needToken: false)
                    let result = try? await httpProvider?.sendAsync([Post].self, request: request!)
                    guard let result = result else {
                        return
                    }
                    
                    print(result)
                }
                
            }) {
                Text("显示二维码")
            }
            
            if(image != nil) {
                SVGView(contentsOf: image!)
                    .frame(width: 240, height: 240, alignment: .center)
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

struct Post: Codable, Hashable {
    var userId: Int32
    var id: Int32
    var title: String
    var body: String
}
