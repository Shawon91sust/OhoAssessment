//
//  ChatRoomViewDI.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 20/3/24.
//

import Foundation

struct ChatRoomViewDI {

    var chatRoomView: ChatRoomView {
        ChatRoomView(viewModel: chatRoomViewModel)
    }
    private var chatRoomViewModel: ChatRoomViewModel {
        ChatRoomViewModel(service: chatService)
    }
    private var chatService: ChatServices {
        ChatAPI()
    }
}
