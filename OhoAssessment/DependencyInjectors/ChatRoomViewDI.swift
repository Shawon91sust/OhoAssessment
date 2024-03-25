//
//  ChatRoomViewDI.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 20/3/24.
//

import Foundation
import SwiftUI

/// Dependency Injection file for ChatRoomView
///
/// Dependencies:
/// - ChatRoomViewModel
/// - ChatServies to make api calls
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
