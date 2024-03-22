//
//  ChatRoomView.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 20/3/24.
//

import SwiftUI
import AlertToast

struct ChatRoomView: View {
    @ObservedObject var viewModel: ChatRoomViewModel
    @State private var roomData: ChatRoomData?
    @State private var showChatHistoryView = false
    
    var body: some View {
        NavigationView {
            VStack {
                //Navigation Title
                VStack {
                    Text("Chats")
                        .font(.custom(Constants.Fonts.SansBold, size: 35))
                        .padding(.leading, 16)
                        .padding(.bottom, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                }
                
                VStack {
                    
                    
                    switch viewModel.state {
                    case .idle:
                        EmptyView()
                    case .loading:
                        LoadingView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    case .failed(let error):
                        InfoView(infoMessage: "")
                    case .loaded(let rooms):
                        if(rooms.isEmpty) {
                            InfoView(infoMessage: "No room found...")
                        } else {
                            ForEach(rooms) { room in
                                ChatRoomCell(data: room) {
                                    
                                    self.roomData = room
                                    showChatHistoryView = true
                                } onLongTap: {
                                    
                                }
                                
                            }
                        }
                    }
                }
                
                Spacer()
                
                if let roomData = roomData {
                    NavigationLink(
                        destination: ChatHistoryViewDI(roomData).chatHistoryView,
                        isActive: $showChatHistoryView,
                        label: {
                            EmptyView()
                        })
                    .hidden() // Hide the navigation link initially
                }
            }
            .onAppear{
                viewModel.fetchChatRooms()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
        
    }
}

#Preview {
    ChatRoomViewDI().chatRoomView
}
