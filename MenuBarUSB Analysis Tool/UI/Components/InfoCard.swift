//
//  InfoCard.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

struct InfoCard<Content: View>: View {
    let icon: String?
    let image: String?
    let title: String
    let subtitle: String?
    let content: () -> Content

    init(
        icon: String? = nil,
        image: String? = nil,
        title: String,
        subtitle: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.icon = icon
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            // Header
            HStack(spacing: 8) {
                if let image {
                    Image(image)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.accent)
                }
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.accent)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.headline)

                    if let subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()
            }

            Divider()

            VStack(alignment: .leading, spacing: 6) {
                content()
            }

        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.background.opacity(0.4))
                .shadow(radius: 2)
        )
    }
}
