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
    @State private var searchTerm: String = ""
    @State private var clickedTip: Bool = false

    var body: some View {
        
        HStack {
            
            TextField(text: $searchTerm) {
                Text("search")
            }
            .multilineTextAlignment(.center)
            
            Button {
                clickedTip.toggle()
            } label: {
                Image(systemName: "book.fill")
            }
            .buttonStyle(.plain)
            .foregroundStyle(clickedTip ? .blue : .secondary)
            
        }
        .opacity(searchTerm.isEmpty ? 0.5 : 1.0)
        .frame(maxWidth: 650)
        
        if clickedTip {
            
            Group {
                Text("search_tip_1")
                Text("search_tip_2")
            }
            .foregroundStyle(.secondary)
            .font(.callout)
            
        }
        
        ScrollView {
            LazyVStack(spacing: 14) {
                InfoCard(icon: "info.circle", imageColor: .primary, title: "info".localized, lightbulb: false) {
                    InfoRow(title: "total", value: vm.totalLogAmount)
                }
                ForEach(Array(vm.filteredLogs(by: searchTerm).enumerated()), id: \.offset) { _, item in
                    LogEntryCardView(log: item.log, previous: item.previous)
                        .contextMenu {
                            Button("ignore_this_device") {
                                if searchTerm.isEmpty {
                                    searchTerm.append("NOT:\(item.log.name)")
                                } else {
                                    searchTerm.append(" + NOT:\(item.log.name)")
                                }
                            }
                        }
                }
            }
            .padding()
        }
        .onAppear {
            vm.fileManager = fileManager
        }
    }
}
