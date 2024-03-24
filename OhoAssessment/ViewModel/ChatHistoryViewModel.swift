//
//  ChatHistoryViewModel.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 21/3/24.
//

import Foundation
import Combine

final class ChatHistoryViewModel: ObservableObject {

    // MARK: - Published properties
    @Published private(set) var state = PageState.idle
    @Published var chatMessage : [ChatMessage] = []

    // MARK: - Properties
    enum PageState {
        case idle
        case loading
        case failed(NetworkError)
        case loaded([ChatMessage])
    }

    private var subscriptions: Set<AnyCancellable> = []
    private let chatService: ChatServices
    

    init(service: ChatServices = ChatAPI()) {
        self.chatService = service
    }
    
    func refresh(_ id : Int) {
        state = .idle
        fetchChatHistory(id)
    }

    // MARK: - Methods
    func fetchChatHistory(_ id : Int) {
        
        self.state = .loading
        chatService.getChatHistory(id: id)
            .sink { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case let .success(payload):
                    self.chatMessage = payload.data.data
                    self.state = .loaded(self.chatMessage)
                case let .failure(error):
                    self.state = .failed(error)
                }
            }
            .store(in: &subscriptions)
    }
    
    func getQrCode(_ id: Int, onCompletion: @escaping (QRCodeObject) -> Void) {
        self.state = .loading
        chatService
            .getQrCode(id: id)
            .sink { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case let .success(payload):
                    Logger.log("QR code payload:\(payload)")
                    onCompletion(payload.data)
                case let .failure(error):
                    Logger.log("QR error:\(error)")
                    
                }
            }
            .store(in: &subscriptions)
    }
    
    func addSocketMessage(data:ChatRoomData, socketMessage: SocketMessageModel) {
        let lastCount = (self.chatMessage.last?.id).safe + 1
        
        print("lastCount \(lastCount)")
        
        let message = ChatMessage(
            id: lastCount,
            body: socketMessage.message,
            sender: socketMessage.userID,
            chatID: data.id,
            chatType: (self.chatMessage.last?.chatType).safe,
            createdAt: socketMessage.time
        )
        
        chatMessage.append(message)
        
        self.state = .loaded(self.chatMessage)
    }
}
