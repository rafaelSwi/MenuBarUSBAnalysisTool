//
//  MetadataTabViewModel.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import Combine
import SwiftUI

@Observable
class MetadataTabViewModel {
    var fileManager: SelectedFileManager?

    var menuBarUsbVersion: String {
        if let v = fileManager?.log?.metadata.appVersion {
            return v
        } else {
            return "unknown".localized
        }
    }

    var machineModel: String {
        if let m = fileManager?.log?.metadata.machineModel {
            return m
        } else {
            return "unknown".localized
        }
    }

    var rawExportedAt: String {
        if let ea = fileManager?.log?.metadata.exportedAt {
            return ea
        } else {
            return "unknown".localized
        }
    }

    var readableExportedAt: String {
        let raw = rawExportedAt
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss:SSS"

        guard let date = formatter.date(from: raw) else {
            return raw
        }

        let out = DateFormatter()
        out.locale = Locale.current
        out.timeZone = TimeZone.current
        out.dateStyle = .long
        out.timeStyle = .short

        return out.string(from: date)
    }
    
    var rawMacVersion: String {
        return fileManager?.log?.metadata.osVersion ?? "no_info".localized
    }

    var majorVersion: Int {
        let versionString = fileManager?.log?.metadata.osVersion

        if versionString == nil {
            return 0
        }

        let components = versionString?.split(separator: ".")

        guard let majorString = components?.first,
              let major = Int(majorString)
        else {
            return 0
        }
        return major
    }

    var macLogo: String {
        switch majorVersion {
        case 13: return "ventura"
        case 14: return "sonoma"
        case 15: return "sequoia"
        case 26: return "tahoe"
        default: return "generic"
        }
    }

    var macVersionName: String {
        switch majorVersion {
        case 13: return "macOS Ventura"
        case 14: return "macOS Sonoma"
        case 15: return "macOS Sequoia"
        case 26: return "macOS Tahoe"
        default: return fileManager?.log?.metadata.osVersion ?? "\(majorVersion)"
        }
    }
}
