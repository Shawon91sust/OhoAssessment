//
//  SocketMessageModel.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 24/3/24.
//

import Foundation


struct SocketMessageModel: Codable {
    let userID: Int
    let message: String
    let time: Int

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case message, time
    }
}
