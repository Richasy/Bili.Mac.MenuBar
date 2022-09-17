//
//  WebView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/9/16.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    @Binding var url: String
    typealias UIViewType = WKWebView
    
    func makeNSView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsAirPlayForMediaPlayback = true
        // configuration.preferences.isElementFullscreenEnabled = true
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.enclosingScrollView?.automaticallyAdjustsContentInsets = false
        return view
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                nsView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
            }
        }
        
        nsView.load(URLRequest(url: URL(string: url)!))
    }
}
