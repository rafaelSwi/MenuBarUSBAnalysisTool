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
            
            InfoChunk(text: "MenuBarUSB Version: \(vm.menuBarUsbVersion)")
            
            InfoChunk(text: "Machine: \(vm.machineModel)")
            
            InfoChunk(text: "Exported At: \(vm.readableExportedAt)")
        }
        .onAppear {
            vm.fileManager = fileManager
        }
    }
}
