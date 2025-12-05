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

    // MARK: - Timestamp → Date
    private func parseDate(_ string: String) -> Date? {
        let f = DateFormatter()
        f.dateFormat = "dd-MM-yyyy HH:mm:ss:SSS"
        f.timeZone = .current
        return f.date(from: string)
    }

    // MARK: - Format timestamp into readable text
    private func prettyDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "dd MMM yyyy • HH:mm:ss"
        return f.string(from: date)
    }

    // MARK: - Time since last log
    private func timeSinceLast(_ previous: Date, _ current: Date) -> String {
        let interval = current.timeIntervalSince(previous)

        if interval < 60 { return "\(Int(interval))s ago" }
        let minutes = Int(interval / 60)
        if minutes < 60 { return "\(minutes)m ago" }
        let hours = minutes / 60
        if hours < 24 { return "\(hours)h ago" }
        return "\(hours / 24)d ago"
    }

    var body: some View {
        let currentDate = parseDate(log.timestamp)
        let previousDate = previous != nil ? parseDate(previous!.timestamp) : nil

        InfoCard(
            icon: log.connect ? "arrow.down.circle.fill" : "arrow.up.circle.fill",
            title: log.name,
            subtitle: log.connect ? "Connected" : "Disconnected"
        ) {

            if let d = currentDate {
                InfoRow(icon: "clock", title: "Timestamp", value: prettyDate(d))
            } else {
                InfoRow(icon: "clock", title: "Timestamp", value: log.timestamp)
            }

            InfoRow(icon: "number", title: "Disposable ID", value: log.disposableId)

            if
                let prev = previousDate,
                let cur = currentDate
            {
                InfoRow(
                    icon: "timer",
                    title: "Since Last",
                    value: timeSinceLast(prev, cur)
                )
            }
        }
    }
}
