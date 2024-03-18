//
//  QRCodeModel.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 19/3/24.
//

import Foundation

struct QRCodeModel: Codable {
    let status: Bool
    let data: QRCodeObject
}

// MARK: - DataClass
struct QRCodeObject: Codable {
    let qrCode: String
    let matchID: Int

    enum CodingKeys: String, CodingKey {
        case qrCode = "qr_code"
        case matchID = "match_id"
    }
}
