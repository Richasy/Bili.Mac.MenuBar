//
//  Bili_Mac_MenuBarApp.swift
//  Bili.Mac.MenuBar
//
//  Created by 张安然 on 2022/8/30.
//

import SwiftUI
import ComposableArchitecture

@main
struct Bili_Mac_MenuBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let diFactory = DIFactory.instance
    
    init() {
        AppDelegate.shared = self.appDelegate
    }
    
    var body: some Scene {
        WindowGroup {
            WindowView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    static var shared : AppDelegate!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = RootView(store: Store(initialState: .init(), reducer: authorizeReducer, environment: .init()))
        
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 600)
        popover.behavior = .transient
        popover.animates = true
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(rootView: contentView)
        
        self.popover = popover;
        
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        guard let button = self.statusBarItem.button else {
            return
        }
        
        button.image = NSImage(named: "Icon")
        button.action = #selector(togglePopover(_:))
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        guard let button = self.statusBarItem.button else {
            return
        }
        
        if self.popover.isShown {
            self.popover.performClose(sender)
        } else {
            self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            self.popover.contentViewController?.view.window?.makeKey()
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
