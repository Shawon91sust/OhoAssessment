//
//  ChatServices.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 19/3/24.
//

import Foundation
import Combine
import Alamofire

protocol ChatServices {
    func getChatRoom() -> AnyPublisher<DataResponse<ChatRoomModel, NetworkError>, Never>
    func getChatHistory(id: Int) -> AnyPublisher<DataResponse<ChatHistoryModel, NetworkError>, Never>
    func getQrCode(id: Int) -> AnyPublisher<DataResponse<QRCodeModel, NetworkError>, Never>
    
}

class ChatAPI: ChatServices {
    
    func getChatRoom() -> AnyPublisher<Alamofire.DataResponse<ChatRoomModel, NetworkError>, Never> {
        let route = ChatRoutes.chatRoom
        return NetworkManager
            .request(route)
            .publishDecodable(type: ChatRoomModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getChatHistory(id: Int) -> AnyPublisher<Alamofire.DataResponse<ChatHistoryModel, NetworkError>, Never> {
        let route = ChatRoutes.chatHistory(id: id)
        return NetworkManager
            .request(route)
            .publishDecodable(type: ChatHistoryModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getQrCode(id: Int) -> AnyPublisher<Alamofire.DataResponse<QRCodeModel, NetworkError>, Never> {
        let route = ChatRoutes.chatQRCode(id: id)
        return NetworkManager
            .request(route)
            .publishDecodable(type: QRCodeModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0) }
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
