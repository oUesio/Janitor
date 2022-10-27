//
//  JanitorApp.swift
//  Janitor
//
//  Created by William Luong on 8/6/21.
//

import SwiftUI

@main
struct JanitorApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .fixedSize()
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification), perform: { _ in
                    for window in NSApplication.shared.windows {
                    window.standardWindowButton(.zoomButton)?.isEnabled = false
                    }
                })
        }//.windowStyle(HiddenTitleBarWindowStyle())
    }
}
