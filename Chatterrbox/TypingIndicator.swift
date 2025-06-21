//
//  TypingIndicator.swift
//  Chatterrbox
//
//  Created by Дмитро Сокотнюк on 24.06.2025.
//

import SwiftUI

struct TypingIndicator: View {
    @State private var animatingDots = false
    
    var body: some View {
        Image(systemName: "ellipsis.bubble")
            .symbolEffect(.variableColor, isActive: animatingDots)
            .font(.title)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .onAppear {
                withAnimation(.linear.repeatForever()) {
                    animatingDots = true
                }
            }
    }
}

#Preview {
    TypingIndicator()
}
