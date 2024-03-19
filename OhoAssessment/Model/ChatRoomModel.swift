//
//  ChatRoomModel.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 19/3/24.
//

import Foundation

struct ChatRoomModel: Codable {
    let status: Bool
    let data: ChatRoom
}

struct ChatRoom: Codable {
    let data: [ChatRoomData]
    let hasNext, hasPrev: Bool

    enum CodingKeys: String, CodingKey {
        case data
        case hasNext = "has_next"
        case hasPrev = "has_prev"
    }
}

struct ChatRoomData: Codable, Identifiable {
    let id: Int
    let channelName, status, participants: String
    let createdAt: Int
    let blockedBy: Int?
    let fullName: String
    let profilePhoto: String
    let gender, lastMessage: String

    enum CodingKeys: String, CodingKey {
        case id
        case channelName = "channel_name"
        case status, participants
        case createdAt = "created_at"
        case blockedBy = "blocked_by"
        case fullName = "full_name"
        case profilePhoto = "profile_photo"
        case gender
        case lastMessage = "last_message"
    }
}
