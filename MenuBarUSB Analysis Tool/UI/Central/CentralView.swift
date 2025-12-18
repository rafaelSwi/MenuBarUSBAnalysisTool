//
//  CentralView.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

struct CentralView: View {
    @State private var vm = CentralViewModel()
    @Environment(\.selectedFileManager) var fileManager

    func categoryButton(tab: Tab, label: String) -> some View {
        var inactive: Bool {
            if tab == .file {
                return false
            } else {
                return !vm.isFileSelected
            }
        }

        return HStack {
            Text(label.localized)
                .font(.system(size: 14.5))
                .fontWeight(.light)
                .foregroundColor(.primary)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .lineLimit(1)
        }
        .background(
            RoundedRectangle(cornerRadius: 2)
                .fill(vm.tab == tab ? Color.accentColor.opacity(0.8) : Color.accentColor.opacity(0.2))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
        .contentShape(Rectangle())
        .opacity(inactive ? 0.3 : 1.0)
        .onTapGesture {
            if !inactive {
                vm.tab = tab
            }
        }
    }

    var body: some View {
        ZStack {
            CustomBackground()
            VStack {
                HStack {
                    categoryButton(tab: .file, label: "file_tab")
                    categoryButton(tab: .logs, label: "logs_tab")
                    categoryButton(tab: .devices, label: "devices_tab")
                    categoryButton(tab: .metadata, label: "metadata_tab")
                }
                .frame(maxWidth: 600)
                .padding(.top, 15)

                Spacer()

                Group {
                    if vm.tab == .file {
                        FileTabView()
                    }

                    if vm.tab == .logs {
                        LogTabView()
                    }

                    if vm.tab == .devices {
                        DevicesTabView()
                    }

                    if vm.tab == .metadata {
                        MetadataTabView()
                    }
                }
                .environment(\.selectedFileManager, fileManager)

                Spacer()
            }
        }
        .frame(minWidth: 600, minHeight: 500)
        .onAppear {
            vm.fileManager = fileManager
        }
    }
}
