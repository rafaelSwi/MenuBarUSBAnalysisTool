//
//  LogTabViewModel.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import Combine
import SwiftUI

@Observable
class LogTabViewModel {
    var fileManager: SelectedFileManager?
    typealias LogInfo = [(log: ExportedLog.LogEntry, previous: ExportedLog.LogEntry?)]

    var logs: LogInfo {
        guard let raw = fileManager?.log?.logs else { return [] }

        let sorted = raw.sorted {
            let f = DateFormatter()
            f.dateFormat = "dd-MM-yyyy HH:mm:ss:SSS"
            let d1 = f.date(from: $0.timestamp) ?? .distantPast
            let d2 = f.date(from: $1.timestamp) ?? .distantPast
            return d1 < d2
        }

        var result: [(ExportedLog.LogEntry, ExportedLog.LogEntry?)] = []
        for i in 0 ..< sorted.count {
            let prev = (i > 0) ? sorted[i - 1] : nil
            result.append((sorted[i], prev))
        }
        return result.reversed()
    }
    
    func filteredLogs(by term: String) -> LogInfo {

        guard !term.isEmpty else {
            return logs
        }

        let parts = term
            .split(separator: "+")
            .map { $0.trimmingCharacters(in: .whitespaces).lowercased() }

        let positiveTerms = parts.filter { !$0.hasPrefix("not:") }
        let blackList = parts
            .filter { $0.hasPrefix("not:") }
            .map { $0.replacingOccurrences(of: "not:", with: "") }

        return logs.filter { log in
            let name = log.log.name.lowercased()

            if blackList.contains(where: { name.contains($0) }) {
                return false
            }

            return positiveTerms.isEmpty ||
                   positiveTerms.contains(where: { name.contains($0) })
        }
    }
    
    var totalLogAmount: String {
       let amount = fileManager?.log?.logs.count
        
        if amount == nil {
            return "no_info".localized
        } else {
            return "\(amount ?? 0)"
        }
        
    }
    
}
