//
//  LogEntryCardView.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

struct LogEntryCardView: View {
    let log: ExportedLog.LogEntry
    let previous: ExportedLog.LogEntry?

    private func parseDate(_ string: String) -> Date? {
        let f = DateFormatter()
        f.dateFormat = "dd-MM-yyyy HH:mm:ss:SSS"
        f.timeZone = .current
        return f.date(from: string)
    }

    private func prettyDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "dd MMM yyyy • HH:mm:ss"
        return f.string(from: date)
    }

    private func timeSinceLast(_ previous: Date, _ current: Date) -> String {
        let interval = current.timeIntervalSince(previous)
        
        if interval < 1 {
            return "less_than_1_sec".localized
        }
        
        if interval < 60 {
            return "\(Int(interval))s"
        }
        
        let minutes = Int(interval / 60)
        if minutes < 60 { return "\(minutes)m" }
        
        let hours = minutes / 60
        if hours < 24 { return "\(hours)h" }
        
        return "\(hours / 24)d"
    }

    var body: some View {
        let currentDate = parseDate(log.timestamp)
        let previousDate = previous != nil ? parseDate(previous!.timestamp) : nil

        InfoCard(
            icon: log.connect ? "circle.circle.fill" : "circle.circle",
            imageColor: Color(log.connect ? "LogConnect" : "LogDisconnect"),
            title: log.name,
            subtitle: log.connect ? "connected" : "disconnected",
            lightbulb: false
        ) {
            if let d = currentDate {
                InfoRow(title: "timestamp", value: prettyDate(d))
            } else {
                InfoRow(title: "timestamp", value: log.timestamp)
            }

            if let prev = previousDate, let cur = currentDate {
                InfoRow(title: "time_interval", value: timeSinceLast(prev, cur))
            }
        }
    }
}
