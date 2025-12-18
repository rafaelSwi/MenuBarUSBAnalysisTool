//
//  CustomBackground.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

struct CustomBackground: View {
    let lineSpacing: CGFloat = 4
    let lineWidth: CGFloat = 1

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(NSColor.controlBackgroundColor).opacity(0.85),
                    Color(NSColor.controlBackgroundColor).opacity(0.65)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            LinearGradient(
                gradient: Gradient(colors: [
                    Color.green.opacity(0.06),
                    Color.green.opacity(0.02)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .blendMode(.overlay)
            .ignoresSafeArea()

            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                let hypotenuse = sqrt(width * width + height * height)
                let numLines = Int(hypotenuse / lineSpacing)

                ForEach(0..<numLines, id: \.self) { i in
                    Path { path in
                        let offset = CGFloat(i) * lineSpacing
                        path.move(to: CGPoint(x: offset, y: 0))
                        path.addLine(to: CGPoint(x: offset - height, y: height))
                    }
                    .stroke(
                        Color.green.opacity(0.05),
                        lineWidth: lineWidth
                    )
                    .blendMode(.screen)
                }
            }
        }
    }
}
