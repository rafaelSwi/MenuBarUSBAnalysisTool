//
//  FileTabViewModel.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import Combine
import AppKit
import UniformTypeIdentifiers
import SwiftUI

@Observable
class FileTabViewModel {
    
    var fileManager: SelectedFileManager?
    
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

            // se for .txt, tentar converter para JSON
            let jsonData: Data
            if url.pathExtension.lowercased() == "txt" {
                if let jsonString = String(data: data, encoding: .utf8)?
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .data(using: .utf8) {
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
                }
            } catch let DecodingError.keyNotFound(key, context) {
                print("⚠️ Chave ausente:", key.stringValue, context.debugDescription)
            } catch let DecodingError.typeMismatch(type, context) {
                print("⚠️ Type mismatch:", type, context.debugDescription)
            } catch {
                print("⚠️ Erro geral:", error.localizedDescription)
            }
            
        } catch {
            DispatchQueue.main.async {
                self.fileManager?.errorMessage = "Falha ao carregar: \(error.localizedDescription)"
            }
        }
    }
    
}
