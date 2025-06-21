//
//  OpenAIResponse.swift
//  Chatterrbox
//
//  Created by Дмитро Сокотнюк on 23.06.2025.
//

import Foundation

struct OpenAIResponse: Decodable {
    let id: String
    let output: [OpenAIMessage]
}

struct OpenAIMessage: Decodable {
    let content: [OpenAIMessageContent]
}

struct OpenAIMessageContent: Decodable {
    let text: String
}
