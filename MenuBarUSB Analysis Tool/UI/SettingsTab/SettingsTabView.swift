//
//  SettingsTabView.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

struct SettingsTabView: View {
    @Environment(\.openURL) var openURL
    @State private var vm = SettingsTabViewModel()
    @AppStorage(StorageKeys.simpleBackground) private var simpleBackground = false
    @AppStorage(StorageKeys.compactLogs) private var compactLogs = false

    @ViewBuilder
    func settingsButton(
        _ title: String,
        value: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: value ? "square.fill" : "square")
            Text(title.localized)
        }
        .buttonStyle(.plain)
    }

    var body: some View {
        VStack {
            
            Group {
                
                Spacer()
                
                settingsButton("simple_background", value: simpleBackground) {
                    simpleBackground.toggle()
                }
                
                settingsButton("compact_logs", value: compactLogs) {
                    compactLogs.toggle()
                }
                
                Spacer()
                
                Button {
                    vm.updateButtonAction(openUrl: openURL)
                } label: {
                    Text(vm.updateButtonLabel.localized)
                }
                
            }
            .font(.system(size: 22, weight: .thin))
            .padding(3)
        }
    }
}
