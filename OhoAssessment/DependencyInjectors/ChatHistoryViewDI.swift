//
//  ChatHistoryViewDI.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 21/3/24.
//

import Foundation

/// Dependency Injection file for QRCodeView
///
/// Dependencies::
/// - ChatRoomData: Show image, username on navigation view, also to fetch chat history, qr code with id and channel_name for fetching socket channel messages.
/// - ChatHistoryViewModel
/// - ChatServies
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
