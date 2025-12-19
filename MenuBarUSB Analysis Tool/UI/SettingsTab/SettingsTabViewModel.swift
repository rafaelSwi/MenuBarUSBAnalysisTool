//
//  SettingsTabViewModel.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import AppKit
import Combine
import SwiftUI
import UniformTypeIdentifiers

@Observable
class SettingsTabViewModel {
    
    var checkingUpdate = false
    var updateAvailable = false
    var latestVersion: String = ""
    var releaseURL: URL? = nil
    
    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return "MenuBarUSB Analysis Tool v\(version)"
    }
    
    var updateButtonLabel: String {
        
        if updateAvailable {
            return "\("download".localized) (v\(latestVersion))";
        }
        
        if checkingUpdate {
            return "looking_for_updates"
        } else if latestVersion.isEmpty {
            return "check_for_updates"
        } else {
            return "updated"
        }
    }
    
    func updateButtonAction(openUrl: OpenURLAction) {
        
        if updateAvailable, let releaseURL {
            openUrl(releaseURL)
            return
        }
        
        checkingUpdate = true
        updateAvailable = false
        latestVersion = ""
        releaseURL = nil
        
        guard
            let url = URL(
                string: "https://api.github.com/repos/rafaelSwi/MenuBarUSBAnalysisTool/releases/latest")
        else {
            checkingUpdate = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            defer { self.checkingUpdate = false }
            guard let data = data, error == nil else { return }
            
            if let release = try? JSONDecoder().decode(GitHubRelease.self, from: data) {
                let latest = release.tag_name.replacingOccurrences(of: "v", with: "")
                self.latestVersion = latest
                self.releaseURL = URL(string: release.html_url)
                
                DispatchQueue.main.async {
                    self.updateAvailable = self.isVersion(self.appVersion, olderThan: latest)
                }
            }
        }.resume()
    }
    
    private func isVersion(_ v1: String, olderThan v2: String) -> Bool {
        let versionPattern = #"(\d+(\.\d+)*)$"#
        
        func extractVersion(_ text: String) -> String? {
            let regex = try? NSRegularExpression(pattern: versionPattern)
            let range = NSRange(text.startIndex..<text.endIndex, in: text)
            if let match = regex?.firstMatch(in: text, range: range),
               let range = Range(match.range(at: 1), in: text) {
                return String(text[range])
            }
            return nil
        }
        
        guard let v1Num = extractVersion(v1) else { return false }
        let v2Num = extractVersion(v2) ?? v2
        
        let v1Components = v1Num.split(separator: ".").compactMap { Int($0) }
        let v2Components = v2Num.split(separator: ".").compactMap { Int($0) }
        
        for (a, b) in zip(v1Components, v2Components) {
            if a < b { return true }
            if a > b { return false }
        }
        
        return v1Components.count < v2Components.count
    }

    
    
}
