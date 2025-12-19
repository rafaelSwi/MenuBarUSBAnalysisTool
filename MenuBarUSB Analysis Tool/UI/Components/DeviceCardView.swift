//
//  DeviceCardView.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

struct DeviceCardView: View {
    let dev: ExportedLog.Device
    
    private func formatSpeed(_ mbps: Int) -> String {
        let value = Double(mbps)
        
        if value >= 1_000_000 {
            let tbps = value / 1_000_000
            return String(format: "%.2f Tbps", tbps)
        } else if value >= 1_000 {
            let gbps = value / 1_000
            return String(format: "%.2f Gbps", gbps)
        } else {
            return "\(mbps) Mbps"
        }
    }

    var body: some View {
        InfoCard(
            icon: nil,
            title: dev.name,
            subtitle: dev.vendor,
            lightbulb: false
        ) {
            InfoRow(title: "vendor_id", value: "\(dev.vendorId)")
            InfoRow(title: "product_id", value: "\(dev.productId)")
            InfoRow(title: "usb_version",
                    value: "0x\(String(format: "%04X", dev.usbVersionBCD))")

            if let loc = dev.locationId {
                InfoRow(title: "location_id",
                        value: String(format: "0x%08X", loc))
            }

            if let serial = dev.serialNumber {
                InfoRow(title: "serial", value: serial)
            }

            if let speed = dev.speedMbps {
                InfoRow(title: "speed", value: formatSpeed(speed))
            }
        }
    }
}
