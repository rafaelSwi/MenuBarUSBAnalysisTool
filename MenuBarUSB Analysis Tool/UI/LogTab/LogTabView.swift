//
//  LogTabView.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

struct LogTabView: View {
    @Environment(\.selectedFileManager) var fileManager
    @State private var vm = LogTabViewModel()

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                InfoCard(icon: "info.circle", imageColor: .primary, title: "info".localized, lightbulb: false) {
                    InfoRow(title: "total", value: vm.totalLogAmount)
                }
                ForEach(Array(vm.logs.enumerated()), id: \.offset) { _, item in
                    LogEntryCardView(log: item.log, previous: item.previous)
                }
            }
            .padding()
        }
        .onAppear {
            vm.fileManager = fileManager
        }
    }
}
