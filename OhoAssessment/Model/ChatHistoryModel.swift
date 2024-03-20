//
//  ChatHistoryModel.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 19/3/24.
//

import Foundation

struct ChatHistoryModel: Codable {
    let status: Bool
    let data: ChatHistory
}

struct ChatHistory: Codable {
    let data: [ChatMessage]
    let hasNext, hasPrev: Bool

    enum CodingKeys: String, CodingKey {
        case data
        case hasNext = "has_next"
        case hasPrev = "has_prev"
    }
}

struct ChatMessage: Codable, Identifiable {
    let id: Int
    let body: String
    let sender, chatID: Int
    let chatType: String
    let createdAt: Int

    enum CodingKeys: String, CodingKey {
        case id, body, sender
        case chatID = "chat_id"
        case chatType = "chat_type"
        case createdAt = "created_at"
    }
}
