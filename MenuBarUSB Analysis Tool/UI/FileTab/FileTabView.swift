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
            .font(.system(size: 35, weight: .thin))
            .buttonStyle(.plain)
            .foregroundStyle(.blue)
            .padding()
            .background(.gray.opacity(0.1))
            .cornerRadius(5)
            
            if vm.selectedFile {
                Text("file_loaded")
            }
            
        }
        .onAppear {
            vm.fileManager = fileManager
        }
    }
}
