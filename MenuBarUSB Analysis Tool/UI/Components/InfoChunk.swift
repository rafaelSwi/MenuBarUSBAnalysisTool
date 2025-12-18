//
//  InfoChunk.swift
//  MenuBarUSB Analysis Tool
//
//  Created by Rafael Neuwirth on 05/12/25.
//

import SwiftUI

struct InfoChunk: View {
    let text: String

    var body: some View {
        HStack {
            Spacer()

            Text(text)
                .font(.title3)
                .padding(.vertical, 2)

            Spacer()
        }
        .background(Color("Chunk"))
        .frame(width: 650)
        .frame(maxWidth: 650)
        .cornerRadius(2)
    }
}
