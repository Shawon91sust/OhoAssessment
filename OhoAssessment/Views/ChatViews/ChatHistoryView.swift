//
//  ChatHistoryView.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 21/3/24.
//

import SwiftUI
import AlertToast

struct ChatHistoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ChatHistoryViewModel
    var data: ChatRoomData
    @State private var qrData: QRCodeObject?
    @State private var showQRCodeView = false
    
    private func qrView(data: QRCodeObject, userName : String) -> some View {
        return QRCodeView(
            data: data,
            userName: userName
        )
    }
    
    
    var body: some View {
        NavigationView {
            VStack(spacing : 0) {
                //Navigation Title
                ChatNavigationView(
                    title: data.fullName,
                    imageUrl: data.profilePhoto) {
                        print("QR Pressed")
                        viewModel.getQrCode(data.id) { qrObj in
                            self.qrData = qrObj
                            showQRCodeView = true
                        }
                        
                    } onTapBack: {
                        print("Back Pressed")
                        self.presentationMode.wrappedValue.dismiss()
                    }.padding(.bottom, 8)
                
                
                VStack {
                    switch viewModel.state {
                    case .idle:
                        EmptyView()
                    case .loading:
                        LoadingView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    case .failed(let error):
                        InfoView(infoMessage: (error.backendError?.error.message).safe)
                    case .loaded(let messages):
                        List(messages) { message in
                            MessageRow(message: message)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .frame( maxWidth: .infinity)
                        }
                        .frame( maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .listStyle(InsetListStyle())
                        .padding(.top, 16)
                        
                    }
                }
                
                
                if let qrData = qrData {
                    NavigationLink(
                        destination: qrView(data: qrData, userName: data.fullName),
                        isActive: $showQRCodeView,
                        label: {
                            EmptyView()
                        })
                    .hidden() // Hide the navigation link initially
                }
                
                
                
                
                
            }
            .onAppear{
                viewModel.fetchChatHistory(data.id)
            }
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
        
        
        
    }
}

#Preview {
    ChatHistoryViewDI(ChatRoomData(id: 100, channelName: "7a4c2e00-7ae6-4983-9e1e-8c5881d8af9d", status: "active", participants: "467,465", createdAt: 1710615891, blockedBy: nil, fullName: "Jane Doe", profilePhoto: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d", gender: "Male", lastMessage: "I'm so glad to hear that you enjoyed our time together! I had a great time too. You're such a genuinely nice person, and I felt really comfortable with you. Looking forward to more adventures together! 😊")).chatHistoryView
}



