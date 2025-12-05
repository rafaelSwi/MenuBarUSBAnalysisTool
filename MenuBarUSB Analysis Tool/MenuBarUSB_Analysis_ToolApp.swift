//
//  MenuBarUSB_Analysis_ToolApp.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

@main
struct MenuBarUSB_Analysis_ToolApp: App {
    
    var fileManager = SelectedFileManager()
    
    var body: some Scene {
        WindowGroup {
            CentralView()
                .environment(\.selectedFileManager, fileManager)
                .environment(\.colorScheme, .dark)
        }
        .windowStyle(.hiddenTitleBar)
    }
}
