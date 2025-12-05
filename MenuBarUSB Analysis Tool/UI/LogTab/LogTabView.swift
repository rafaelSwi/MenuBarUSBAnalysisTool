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
            VStack(spacing: 14) {
                ForEach(Array(vm.logs.enumerated()), id: \.offset) { index, item in
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
