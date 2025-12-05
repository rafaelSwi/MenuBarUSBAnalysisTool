//
//  InfoRow.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
                .frame(width: 28)

            Text(title + ":")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.subheadline)

            Spacer()
        }
    }
}
