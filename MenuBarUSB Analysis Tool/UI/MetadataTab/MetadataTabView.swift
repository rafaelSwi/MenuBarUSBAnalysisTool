//
//  MetadataTabView.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

struct MetadataTabView: View {
    @Environment(\.selectedFileManager) var fileManager
    @State private var vm = MetadataTabViewModel()

    var body: some View {
        VStack {
            HStack {
                Text(vm.macVersionName)
                    .font(.title)

                Image(vm.macLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .cornerRadius(50)
            }
            .padding()
            
            InfoChunk(text: "macOS: \(vm.rawMacVersion)")

            InfoChunk(text: "\("menubarusb_version".localized): \(vm.menuBarUsbVersion)")

            InfoChunk(text: "\("machine".localized): \(vm.machineModel)")

            InfoChunk(text: "\("exported_at".localized): \(vm.readableExportedAt)")
        }
        .onAppear {
            vm.fileManager = fileManager
        }
    }
}
