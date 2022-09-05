//
//  ContentView.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/30.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        authorizeProvider = DIFactory.instance.container.resolve(AuthorizeProviderProtocol.self)!
    }
    
    private let authorizeProvider: AuthorizeProviderProtocol
    
    @State var authorizeState: AuthorizeState = .signedOut
    
    var body: some View {
        
        VStack {
            if authorizeState == .signedOut {
                SignInView()
                    .frame(maxWidth:.infinity, maxHeight: .infinity)
            } else {
                SubscribeView()
                .frame(maxWidth:.infinity, maxHeight: .infinity)
            }
        }.onAppear {
            authorizeProvider.events.addEvent(id: "ContentView", name: EventKeys.authorizeStateChanged.rawValue) { data in
                self.authorizeState = data as! AuthorizeState
            }
            
            Task {
                await authorizeProvider.trySignInAsync()
            }
        }
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
