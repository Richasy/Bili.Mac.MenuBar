//
//  Bili_Mac_MenuBarApp.swift
//  Bili.Mac.MenuBar
//
//  Created by Richasy on 2022/8/30.
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
    var viewStore: ViewStore<AppState, AppAction>!
    var playerWindows: [NSWindow] = [NSWindow]()
    static var shared : AppDelegate!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let store = Store(initialState: .init(), reducer: appReducer, environment: .init())
        viewStore = ViewStore(store)
        let contentView = RootView(store: store)
        
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 640)
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
        print(GRPCConfig(accessToken: "sdasdas").getLocaleBin())
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
            
            if viewStore.state.autoRefresh {
                self.viewStore.send(AppAction.refresh)
            }
        }
    }
    
    @objc func openPlayerWindow() {
        let url = UserDefaults.standard.string(forKey: "TempUrl");
        guard let url = url else {
            return
        }
        
        let playerWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1600, height: 900),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false)
        playerWindow.center()
        playerWindow.setFrameAutosaveName("Player")
        playerWindow.isReleasedWhenClosed = true
        let playerView = PlayerView(url: url)
        playerWindow.contentView = NSHostingView(rootView: playerView)
        
        playerWindow.makeKeyAndOrderFront(nil)
        playerWindows.append(playerWindow)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
