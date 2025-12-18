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

    var logs: [(log: ExportedLog.LogEntry, previous: ExportedLog.LogEntry?)] {
        guard let raw = fileManager?.log?.logs else { return [] }

        // ordenar por tempo sem extensões
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
        return result
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
