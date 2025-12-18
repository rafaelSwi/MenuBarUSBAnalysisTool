//
//  DevicesTabViewModel.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import Combine
import SwiftUI

@Observable
class DevicesTabViewModel {
    var fileManager: SelectedFileManager?

    var devices: [ExportedLog.Device] {
        return fileManager?.log?.devices ?? []
    }
}
