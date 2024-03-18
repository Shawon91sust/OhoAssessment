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
    
    var baseURL : String {""}
    var path: String {
        switch self {
        case .chatRoom:
            return "/chat/rooms"
        case .chatHistory(let id):
            return "/chat/history"
        case .chatQRCode(let id):
            return "/match/get_qr_code"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .chatRoom:
            return .get
        case .chatHistory(let id), .chatQRCode(let id):
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
        case .chatHistory(let id), .chatQRCode(let id):
            return nil
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .chatRoom:
            return [.authorization(Constants.baseURL)]
        case .chatHistory(let id), .chatQRCode(let id):
            return [.authorization(Constants.baseURL)]
        }
    }
    
}
