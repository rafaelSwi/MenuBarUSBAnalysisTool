//
//  SelectedFileManager.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import Foundation
import Combine

@Observable
class SelectedFileManager {
    var errorMessage: String?
    var log: ExportedLog?
}
