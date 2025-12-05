//
//  FileTabView.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

struct FileTabView: View {
    
    @Environment(\.selectedFileManager) var fileManager
    @State private var vm = FileTabViewModel()
    
    var body: some View {
        VStack {
            
            Button("select_file") {
                vm.openFile()
            }
            
            Text(fileManager.log == nil ? "no_file_selected" : "loaded")
            
            
        }
        .onAppear {
            vm.fileManager = fileManager
        }
    }
}
