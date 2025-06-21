//
//  Message.swift
//  Chatterrbox
//
//  Created by Дмитро Сокотнюк on 23.06.2025.
//

import Foundation

struct Message: Equatable, Identifiable {
    var id = UUID().uuidString
    var text: String
    var isAI: Bool
    var timestamp = Date.now
}
