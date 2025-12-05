//
//  DevicesTabView.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

struct DevicesTabView: View {
    
    @Environment(\.selectedFileManager) var fileManager
    @State private var vm = DevicesTabViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(vm.devices, id: \.self) { device in
                    DeviceCardView(dev: device)
                }
            }
        }
        .onAppear {
            vm.fileManager = fileManager
        }
    }
}
