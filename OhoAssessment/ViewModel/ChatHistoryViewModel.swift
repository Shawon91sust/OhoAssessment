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

    // MARK: - Methods
    func fetchChatHistory(_ id : Int) {
        self.state = .loading
        chatService.getChatHistory(id: id)
            .sink { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case let .success(payload):
                    self.state = .loaded(payload.data.data)
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
}
