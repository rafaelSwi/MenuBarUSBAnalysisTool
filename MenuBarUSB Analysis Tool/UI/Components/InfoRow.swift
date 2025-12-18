//
//  InfoRow.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI
import AppKit

struct InfoRow: View {
    let title: String
    let value: String
    
    @State private var isCopied = false
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Text(title.localized + ":")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(isCopied ? "copied".localized : value)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            copyToClipboard()
        }
    }
    
    private func copyToClipboard() {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(value, forType: .string)
        
        isCopied = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isCopied = false
        }
    }
}
