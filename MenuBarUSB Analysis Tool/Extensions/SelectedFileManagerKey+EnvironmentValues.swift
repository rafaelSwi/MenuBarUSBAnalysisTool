//
//  SelectedFileManagerKey+EnvironmentValues.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

extension EnvironmentValues {
    var selectedFileManager: SelectedFileManager {
        get { self[SelectedFileManagerKey.self] }
        set { self[SelectedFileManagerKey.self] = newValue }
    }
}
