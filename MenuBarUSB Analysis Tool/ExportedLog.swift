//
//  ExportedLog.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import Foundation

struct ExportedLog: Codable {
    struct Metadata: Codable {
        let exportedAt: String
        let machineModel: String
        let osVersion: String
        let appVersion: String
    }

    struct Device: Codable, Identifiable, Hashable {
        let disposableId: String
        let name: String
        let vendor: String?
        let vendorId: Int
        let serialNumber: String?
        let speedMbps: Int?
        let usbVersionBCD: Int
        let productId: Int
        let locationId: Int?
        let serial: String? = nil
        
        var id: String { disposableId }

        enum CodingKeys: String, CodingKey {
            case disposableId
            case name
            case vendor
            case vendorId
            case serialNumber
            case speedMbps
            case usbVersionBCD
            case productId
            case locationId
        }
    }

    struct LogEntry: Codable {
        let timestamp: String
        let connect: Bool
        let name: String
        let disposableId: String

        enum CodingKeys: String, CodingKey {
            case timestamp = "time"
            case connect
            case name
            case disposableId
        }
    }

    let metadata: Metadata
    let devices: [Device]
    let logs: [LogEntry]
}
