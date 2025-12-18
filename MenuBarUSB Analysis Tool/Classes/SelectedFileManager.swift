//
//  SelectedFileManager.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import Combine
import Foundation

@Observable
class SelectedFileManager {
    var errorMessage: String?
    var log: ExportedLog?
}
