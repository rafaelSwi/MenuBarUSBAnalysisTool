//
//  DeviceCardView.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

struct DeviceCardView: View {
    let dev: ExportedLog.Device

    var body: some View {
        InfoCard(
            icon: nil,
            image: "usb",
            title: dev.name,
            subtitle: dev.vendor
        ) {
            InfoRow(icon: "number", title: "Vendor ID", value: "\(dev.vendorId)")
            InfoRow(icon: "number", title: "Product ID", value: "\(dev.productId)")
            InfoRow(icon: "bolt.horizontal", title: "USB Version",
                    value: "0x\(String(format: "%04X", dev.usbVersionBCD))")

            if let loc = dev.locationId {
                InfoRow(icon: "mappin.circle", title: "Location ID",
                        value: String(format: "0x%08X", loc))
            }

            if let serial = dev.serialNumber {
                InfoRow(icon: "barcode", title: "Serial", value: serial)
            }

            if let speed = dev.speedMbps {
                InfoRow(icon: "speedometer", title: "Speed", value: "\(speed) Mbps")
            }
        }
    }
}
