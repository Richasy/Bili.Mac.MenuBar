//
//  ContentView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/30.
//

import SwiftUI
import QRCodeGenerator
import SVGView

struct ContentView: View {
    
    let imageAdapter = DIFactory.instance.container.resolve(ImageAdapterProtocol.self)
    
    @State var image: URL? = nil
    
    var body: some View {
        VStack{
            Button(action: {
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
