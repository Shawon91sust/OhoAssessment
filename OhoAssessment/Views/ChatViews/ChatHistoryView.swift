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
    @StateObject var viewModel: ChatHistoryViewModel
    var data: ChatRoomData
    @State private var qrData: QRCodeObject?
    @State private var showQRCodeView = false
    @State private var showToast = false
    @State private var errMsg : String = ""
    @State private var chatMsg: String = ""
    @FocusState private var chatFieldIsFocused
    @State private var opacity: Double = 0
    
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
                        EmptyView()

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
                
                Spacer()
                
                HStack(spacing : 16) {
                    TextField(
                            "Message...",
                            text: $chatMsg
                    )
                    .padding(.horizontal)
                    .frame(height: 65)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.gray, lineWidth: 1)
                    )
                    .focused($chatFieldIsFocused)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.leading)
                    
                    Button {
                        print(chatMsg)
                        self.hideKeyboard()
                        SocketHandler.shared.sendChat(roomName: data.channelName, message: chatMsg)
                        chatMsg = ""
                    } label: {
                        Image("Send", bundle: nil)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 65, height: 65)
                    .padding(.trailing)
                    
                    
                }
                .background(.clear)

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
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                // Refresh your view's data here
                print(data.fullName)
                viewModel.refresh(data.id)
            }
            .onTapGesture {
                self.hideKeyboard()
            }
            .onAppear{
                
                viewModel.fetchChatHistory(data.id)
                
                
                SocketHandler.shared.enterChatroom(data.channelName) { message in
                    if let message = message {
                        viewModel.addSocketMessage(data: data, socketMessage: message)
                    }
                }
                
                let socket = SocketHandler.shared.socket
                
                socket.on("\(data.id)") { dataArray, ack in
                    guard let firstElement = dataArray.first as? [String: Any],
                          let jsonData = try? JSONSerialization.data(withJSONObject: firstElement),
                          let model = try? JSONDecoder().decode(SocketMessageModel.self, from: jsonData) else {
                        
                        return
                    }
                    
                    viewModel.addSocketMessage(data: data, socketMessage: model)
                }
                
            }
            .overlay {
                if showToast {
                    VStack {
                        Spacer()
                        ToastView(errorTitle: viewModel.errMessage)
                            .opacity(opacity)
                            .onAppear {
                                    withAnimation(Animation.linear(duration: 1)) {
                                        opacity = 1 
                                    }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        showToast = false
                                    }
                                    
                                }
                            }
                            
                    }
                    
                }
            }
            .task {
                if(!viewModel.errMessage.isEmpty) {
                    errMsg = viewModel.errMessage
                    showToast = true
                }
                
            }
            
            
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
        
        
        
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ChatHistoryViewDI(ChatRoomData(id: 100, channelName: "7a4c2e00-7ae6-4983-9e1e-8c5881d8af9d", status: "active", participants: "467,465", createdAt: 1710615891, blockedBy: nil, fullName: "Jane Doe", profilePhoto: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d", gender: "Male", lastMessage: "I'm so glad to hear that you enjoyed our time together! I had a great time too. You're such a genuinely nice person, and I felt really comfortable with you. Looking forward to more adventures together! 😊")).chatHistoryView
}



