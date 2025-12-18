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
            Button {
                vm.openFile()
            } label: {
                Text("select_file")
                    .font(.system(size: 35, weight: .thin))
            }
            .padding()
            
            if vm.selectedFile {
                Text("file_loaded")
            }
            
        }
        .onAppear {
            vm.fileManager = fileManager
        }
    }
}
