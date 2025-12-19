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
    let imageColor: Color?
    let title: String
    let subtitle: String?
    let lightbulb: Bool
    let content: () -> Content

    @State private var isHighlighted = false
    @AppStorage(StorageKeys.compactLogs) private var compactLogs = false

    init(
        icon: String? = nil,
        image: String? = nil,
        imageColor: Color? = nil,
        title: String,
        subtitle: String? = nil,
        lightbulb: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.icon = icon
        self.image = image
        self.imageColor = imageColor
        self.title = title
        self.subtitle = subtitle
        self.lightbulb = lightbulb
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: compactLogs ? 6 : 10) {
            HStack(spacing: compactLogs ? 6 : 8) {
                if let image, !compactLogs {
                    Image(image)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .cornerRadius(20)
                }

                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: compactLogs ? 14 : 18, weight: .medium))
                        .foregroundStyle(imageColor ?? .accent)
                }

                VStack(alignment: .leading, spacing: compactLogs ? 0 : 2) {
                    Text(title.localized)
                        .font(compactLogs ? .subheadline : .headline)

                    if let subtitle {
                        Text(subtitle.localized)
                            .font(compactLogs ? .caption : .subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                if lightbulb {
                    Button {
                        isHighlighted.toggle()
                    } label: {
                        Image(systemName: compactLogs ? "lightbulb.fill" : "lightbulb.circle.fill")
                            .font(compactLogs ? .system(size: 14) : .system(size: 25))
                            .opacity(isHighlighted ? 1.0 : 0.2)
                    }
                    .buttonStyle(.plain)
                }
            }

            if !compactLogs {
                Divider()
            }

            VStack(alignment: .leading, spacing: compactLogs ? 2 : 6) {
                content()
                    .font(compactLogs ? .caption2 : .body)
            }
        }
        .padding(compactLogs ? 8 : 14)
        .background(
            RoundedRectangle(cornerRadius: compactLogs ? 8 : 12, style: .continuous)
                .fill(
                    isHighlighted
                    ? Color.yellow.opacity(0.15)
                    : Color.primary.opacity(compactLogs ? 0.03 : 0.05)
                )
        )
        .animation(.easeInOut(duration: 0.15), value: isHighlighted)
    }
}
