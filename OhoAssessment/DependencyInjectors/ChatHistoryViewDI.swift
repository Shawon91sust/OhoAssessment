//
//  ChatHistoryViewDI.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 21/3/24.
//

import Foundation

struct ChatHistoryViewDI {

    var chatHistoryView: ChatHistoryView {
        ChatHistoryView(viewModel: chatHistoryViewModel, data: chatRoomData)
    }
    private var chatHistoryViewModel: ChatHistoryViewModel {
        ChatHistoryViewModel(service: chatService)
    }
    private var chatService: ChatServices {
        ChatAPI()
    }
    
    private var chatRoomData: ChatRoomData {
        ChatRoomData(id: 100, channelName: "", status: "", participants: "", createdAt: 00, blockedBy: -1, fullName: "Shawon Reja", profilePhoto: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d", gender: "Male", lastMessage: "Hi how are you")
    }
}
