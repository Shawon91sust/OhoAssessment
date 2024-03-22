//
//  ChatHistoryViewDI.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 21/3/24.
//

import Foundation

struct ChatHistoryViewDI {
    
    private var chatRoomData : ChatRoomData

    var chatHistoryView: ChatHistoryView {
        ChatHistoryView(viewModel: chatHistoryViewModel, data: chatRoomData)
    }
    private var chatHistoryViewModel: ChatHistoryViewModel {
        ChatHistoryViewModel(service: chatService)
    }
    private var chatService: ChatServices {
        ChatAPI()
    }
    
    init(_ chatRoomData : ChatRoomData) {
        self.chatRoomData = chatRoomData
    }
    
    
}
