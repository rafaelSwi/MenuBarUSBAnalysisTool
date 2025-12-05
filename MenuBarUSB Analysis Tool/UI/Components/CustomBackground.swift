//
//  BrushedMetalBackground.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

struct CustomBackground: View {

    let squareSize: CGFloat = 6

    var body: some View {
        ZStack {
            Color.black

            GeometryReader { geo in
                let cols = Int(geo.size.width / squareSize)
                let rows = Int(geo.size.height / squareSize)

                ForEach(0..<rows, id: \.self) { y in
                    ForEach(0..<cols, id: \.self) { x in
                        Rectangle()
                            .fill((x + y).isMultiple(of: 2)
                                  ? Color.white.opacity(0.07)
                                  : Color.black.opacity(0.6))
                            .frame(width: squareSize, height: squareSize)
                            .position(
                                x: CGFloat(x) * squareSize + squareSize / 2,
                                y: CGFloat(y) * squareSize + squareSize / 2
                            )
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}
