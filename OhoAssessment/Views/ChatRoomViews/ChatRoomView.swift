//
//  ChatRoomView.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 20/3/24.
//

import SwiftUI
import AlertToast

struct ChatRoomView: View {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var viewModel: ChatRoomViewModel
    @State private var roomData: ChatRoomData?
    @State private var showChatHistoryView = false
    @State private var isSheetPresented = false
    @State private var isBlockPresented = false
    @State private var isReportPresented = false
    @State private var selectedRoomIndex : Int = 0
    
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
                            
                            ScrollView {
                                VStack(spacing: 0) {
                                    ForEach(rooms.indices, id: \.self) { index in
                                        
                                        ChatRoomCell(data: rooms[index]) {
                                            self.roomData = rooms[index]
                                            showChatHistoryView = true
                                        } onLongTap: {
                                            
                                            self.roomData = rooms[index]
                                            self.selectedRoomIndex = index
                                            isSheetPresented = true
                                            
                                        }  
                                    }
                                    
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
                    .hidden()
                }
            }
            .onAppear{
                SocketHandler.shared.connect()
                viewModel.fetchChatRooms()
            }
        }
        .overlay(content: {
            if(isBlockPresented) {
                BlockPopUp(chatdata: $roomData, showBlockPopup: $isBlockPresented)
            }
            
            if(isReportPresented) {
                ReportPopUp(chatdata: $roomData, showReportPopup: $isReportPresented)
            }
            
            if(isSheetPresented) {
                ChatBottomSheet(chatdata: $roomData, showChatBottomSheet: $isSheetPresented) {
                    isSheetPresented = false
                    isBlockPresented = true
                } onReport: {
                    isSheetPresented = false
                    isReportPresented = true
                }

            }
        })
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
        .onChange(of: scenePhase) { oldPhase, newScenePhase in
            switch newScenePhase {
            case .active:
                print("App became active")
            case .inactive, .background:
                SocketHandler.shared.disconnect()
            @unknown default:
                break
            }
        }
        
    }
    
    func sheetPosition() -> CGPoint {
        
        let index = selectedRoomIndex
        let cellHeight: CGFloat = 160
        let yOffset = (CGFloat(index + 1) * cellHeight) - CGFloat(index * 12)
        print(yOffset)
        return CGPoint(x: 55, y: yOffset)
    }
}

#Preview {
    ChatRoomViewDI().chatRoomView
}


struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode
    var onBlock: ()-> Void
    var onReport: ()-> Void

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Button("Block") {
                // Action for Button 1
                presentationMode.wrappedValue.dismiss()
                onBlock()
            }
            

            Button("Report") {
                // Action for Button 2
                presentationMode.wrappedValue.dismiss()
                onReport()
            }
        }
        .padding()
        .background(Color.white)
        .border(.black)
    }
}
