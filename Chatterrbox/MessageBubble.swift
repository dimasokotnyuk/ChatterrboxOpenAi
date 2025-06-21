//
//  MessageBubble.swift
//  Chatterrbox
//
//  Created by Дмитро Сокотнюк on 24.06.2025.
//

import SwiftUI

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        let alignment = message.isAI ? Alignment.leading : Alignment.trailing
        //
        Text(.init(message.text))
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .foregroundStyle(message.isAI ? Color.primary : Color.white)
            .background(message.isAI ? .gray.opacity(0.2) : .blue)
            .clipShape(.rect(cornerRadius: 16))
            .containerRelativeFrame(.horizontal, alignment: alignment) { size, axis in
                size * 0.75
            }
            .frame(maxWidth: .infinity, alignment: alignment)
            .transition(.move(edge: message.isAI ? .leading : .trailing))
            .id(message.id)
    }
}

#Preview {
    MessageBubble(message: Message(text: "hello", isAI: false))
}
