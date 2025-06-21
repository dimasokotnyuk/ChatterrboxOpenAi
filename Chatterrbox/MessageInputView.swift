//
//  MessageInputView.swift
//  Chatterrbox
//
//  Created by Дмитро Сокотнюк on 24.06.2025.
//

import SwiftUI

struct MessageInputView: View {
    @FocusState private var isInputFocused: Bool
    @Binding var messageText: String
    let onSend: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            TextField("Напиши щось", text: $messageText, axis: .vertical)
                .focused($isInputFocused)
                .textFieldStyle(.roundedBorder)
                .onSubmit(sendMessage)
            
            Button("Send Message", systemImage: "arrow.up.circle.fill", action: onSend)
                .labelStyle(.iconOnly)
                .font(.title)
                .disabled(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .onAppear {
            isInputFocused = true
        }
    }
    
    func sendMessage() {
        onSend()
        isInputFocused = true
    }
}

#Preview {
    MessageInputView(messageText: .constant("Example")) {
        
    }
}
