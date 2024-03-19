//
//  ChatRoutes.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 19/3/24.
//

import Foundation
import Alamofire

enum ChatRoutes: BaseRequest {
    
    case chatRoom
    case chatHistory(id: Int)
    case chatQRCode(id: Int)
    
    var baseURL : String {Constants.baseURL}
    var path: String {
        switch self {
        case .chatRoom:
            return "/chat/rooms"
        case .chatHistory(_):
            return "/chat/history"
        case .chatQRCode(_):
            return "/match/get_qr_code"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .chatRoom:
            return .get
        case .chatHistory(_), .chatQRCode(_):
            return .get
        }
    }
    
    var queries: [String : String]? {
        switch self {
        case .chatRoom:
            return nil
        case .chatHistory(let id), .chatQRCode(let id):
            return ["chat_id": "\(id)"]
        }
    }
    
    var params: Alamofire.Parameters? {
        switch self {
        case .chatRoom:
            return nil
        case .chatHistory(_), .chatQRCode(_):
            return nil
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .chatRoom:
            return [.authorization(Constants.authToken)]
        case .chatHistory(_), .chatQRCode(_):
            return [.authorization(Constants.authToken)]
        }
    }
    
}
