//
//  InfoCard.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

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
        VStack(alignment: .leading, spacing: 10) {
            // Header
            HStack(spacing: 8) {
                if let image {
                    Image(image)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .cornerRadius(20)
                }

                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(imageColor ?? .accent)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(title.localized)
                        .font(.headline)

                    if let subtitle {
                        Text(subtitle.localized)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()
                
                if lightbulb {
                    Button {
                        toggleHighlight()
                    } label: {
                        Image(systemName: "lightbulb.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .opacity(isHighlighted ? 1.0 : 0.2)
                    }
                    .buttonStyle(.plain)
                }
                
            }

            Divider()

            VStack(alignment: .leading, spacing: 6) {
                content()
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(
                    isHighlighted
                    ? Color.yellow.opacity(0.15)
                    : Color.primary.opacity(0.05)
                )
        )
        .animation(.easeInOut(duration: 0.15), value: isHighlighted)
        .contentShape(RoundedRectangle(cornerRadius: 12))
    }

    private func toggleHighlight() {
        isHighlighted.toggle()
    }
}
