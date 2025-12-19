//
//  FileTabViewModel.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import AppKit
import Combine
import SwiftUI
import UniformTypeIdentifiers

@Observable
class FileTabViewModel {
    var fileManager: SelectedFileManager?
    var selectedFile: Bool = false
    
    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return "MenuBarUSB Analysis Tool v\(version)"
    }

    func openFile() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.json, .plainText]
        panel.allowsMultipleSelection = false

        panel.begin { result in
            if result == .OK, let url = panel.url {
                self.loadFile(url)
            }
        }
    }

    private func loadFile(_ url: URL) {
        do {
            let data = try Data(contentsOf: url)

            let jsonData: Data
            if url.pathExtension.lowercased() == "txt" {
                if let jsonString = String(data: data, encoding: .utf8)?
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .data(using: .utf8)
                {
                    jsonData = jsonString
                } else {
                    throw NSError(domain: "TXT inválido", code: 100)
                }
            } else {
                jsonData = data
            }

            do {
                let decoded = try JSONDecoder().decode(ExportedLog.self, from: jsonData)
                DispatchQueue.main.async {
                    self.fileManager?.log = decoded
                    self.fileManager?.errorMessage = nil
                    self.selectedFile = true
                }
            } catch let DecodingError.keyNotFound(key, context) {
                print("no key:", key.stringValue, context.debugDescription)
            } catch let DecodingError.typeMismatch(type, context) {
                print("type mismatch:", type, context.debugDescription)
            } catch {
                print("general error:", error.localizedDescription)
            }

        } catch {
            DispatchQueue.main.async {
                self.fileManager?.errorMessage = "fail to load: \(error.localizedDescription)"
            }
        }
    }
}
