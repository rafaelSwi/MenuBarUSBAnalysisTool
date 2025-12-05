//
//  CentralViewModel.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI
import UniformTypeIdentifiers
import Combine

@Observable
class CentralViewModel {
    
    var fileManager: SelectedFileManager?
    
    var tab: Tab = .file
    
    var isFileSelected: Bool {
        return fileManager?.log != nil
    }

    
}
