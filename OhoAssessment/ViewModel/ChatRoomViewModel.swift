//
//  ChatRoomViewModel.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 20/3/24.
//

import Foundation
import Combine

final class ChatRoomViewModel: ObservableObject {

    // MARK: - Published properties
    @Published private(set) var state = PageState.idle


    // MARK: - Properties
    enum PageState {
        case idle
        case loading
        case failed(NetworkError)
        case loaded([ChatRoomData])
    }

    private var subscriptions: Set<AnyCancellable> = []
    private let chatService: ChatServices
    

    init(service: ChatServices) {
        self.chatService = service
    }

    // MARK: - Methods
    func fetchChatRooms() {
        self.state = .loading
        chatService.getChatRoom()
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
}
