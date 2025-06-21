//
//  ContentView.swift
//  Chatterrbox
//
//  Created by Дмитро Сокотнюк on 21.06.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var client = APIClient(apiKey: "YOUR_OPEN_AI_KEY")
    var instructionsForFunc = "Ти — Чаттербокс, бот, створений виключно для спілкування. Ти звертаєшся до неповнолітніх, тому ніколи не використовуй і не допускай образливої лексики. Обов’язково використовуй у відповідях елементи Markdown, наприклад жирний текст або курсив."



    
    @State private var messages = [Message]()
    @State private var messageText: String = ""
    
    @State private var isTyping = false

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(messages, content: MessageBubble.init)
                            
                            if isTyping {
                                HStack {
                                    TypingIndicator()
                                    Spacer()
                                }.transition(.move(edge: .leading))
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .defaultScrollAnchor(.bottom)
                    .onChange(of: messages) {
                        Task {
                            try await Task.sleep(for: .seconds(0.2))
                            
                            proxy.scrollTo(messages.last?.id, anchor: .bottom)
                        }
                    }
                }
                
                MessageInputView(messageText: $messageText, onSend: sendMessage)
            }
        }
    }
    
    func sendMessage() {
        let prompt = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard prompt.isEmpty == false else { return }
        
        messageText = ""
        
        withAnimation {
            messages.append(Message(text: prompt, isAI: false))
        }
        
        Task {
            do {
                let lastAIMEssage = messages.last(where: \.isAI)
                
                async let response = client.generateText(from: prompt, instructions: instructionsForFunc, previousResponse: lastAIMEssage?.id)
                
                try await Task.sleep(for: .seconds(1))
                isTyping = true
                
                try await Task.sleep(for: .seconds(2))
                
                let newMessage = try await Message(id: response.id, text: response.message, isAI: true)
                
                isTyping = false
                
                withAnimation {
                    messages.append(newMessage)
                }
            } catch {
                print(error.localizedDescription)
                isTyping = false
            }
        }
    }
}

#Preview {
    ContentView()
}
