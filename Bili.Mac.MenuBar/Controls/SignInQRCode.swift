//
//  SignInQRCode.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/2.
//

import SwiftUI
import SVGView

struct SignInQRCode: View {
    
    init() {
        authorizeProvider = DIFactory.instance.container.resolve(AuthorizeProviderProtocol.self)!
    }
    
    private var authorizeProvider: AuthorizeProviderProtocol
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @State var isLoadingImage: Bool = false
    @State var isLoadingFailed: Bool = false
    @State var imageURL: URL? = nil
    @State var qrcodeState: QRCodeState = .notConfirm
    
    var body: some View {
        VStack {
            if isLoadingImage {
                HStack(spacing: 8) {
                    ProgressView()
                    Text("加载中...")
                        .foregroundColor(.secondary)
                }
            } else if isLoadingFailed {
                Text("获取二维码失败，请稍后重试")
                    .foregroundColor(.secondary)
                Button(action: {
                    loadQRCodeImage()
                }) {
                    Text("刷新二维码")
                }
                .buttonStyle(.link)
                .padding([.top], 10)
            } else if imageURL != nil {
                SVGView(contentsOf: imageURL!)
                    .frame(width: 240, height: 240, alignment: .center)
                    .onReceive(timer) { input in
                        loopCheck()
                    }
                
                Text("请使用移动客户端扫码登录")
                    .foregroundColor(.secondary)
                    .padding([.top], 16)
                
                if authorizeProvider.qrCodeState != .success {
                    Button(action: {
                        loadQRCodeImage()
                    }) {
                        Text("刷新二维码")
                    }
                    .buttonStyle(.link)
                    .padding([.top], 12)
                }
            }
        }.onAppear {
            authorizeProvider.events.addEvent(id: "SignInQRCode", name: EventKeys.qrcodeStateChanged.rawValue) { data in
                self.qrcodeState = data as! QRCodeState
            }
            
            loadQRCodeImage()
        }.onDisappear {
            authorizeProvider.events.removeEvent(id: "SignInQRCode", name: EventKeys.qrcodeStateChanged.rawValue)
            removeLocalCache()
        }
    }
    
    private func loadQRCodeImage() {
        isLoadingImage = true
        Task {
            
            let svg = await authorizeProvider.getQRCodeImageAsync()
            
            guard !svg.isEmpty else {
                isLoadingFailed = true
                isLoadingImage = false
                return
            }
            
            var url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            url.appendPathComponent("bili_signin_qrcode.svg")
            if let data = svg.data(using: .utf8) {
                try? data.write(to: url)
                imageURL = url
            }
            
            isLoadingImage = false
        }
    }
    
    private func removeLocalCache() {
        guard let imageURL = imageURL else {
            return
        }
        
        try? FileManager.default.removeItem(atPath: imageURL.path)
        self.imageURL = nil
        timer.upstream.connect().cancel()
    }
    
    private func loopCheck() {
        print("Timer triggered")
        guard imageURL != nil else {
            return
        }
        
        Task {
            await authorizeProvider.loopQRCodeStatusAsync()
        }
    }
}

struct SignInQRCode_Previews: PreviewProvider {
    static var previews: some View {
        SignInQRCode()
            .frame(width: 200, height: 260, alignment: .center)
    }
}
