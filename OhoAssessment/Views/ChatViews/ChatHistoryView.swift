//
//  ChatHistoryView.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 21/3/24.
//

import SwiftUI
import AlertToast

struct ChatHistoryView: View {
    @ObservedObject var viewModel: ChatHistoryViewModel
    var data: ChatRoomData
    
    
    
    var body: some View {
        VStack(spacing : 0) {
            //Navigation Title
            ChatNavigationView(
                title: data.fullName,
                imageUrl: data.profilePhoto) {
                    print("QR Pressed")
                } onTapBack: {
                    print("Back Pressed")
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
                
                
                
               
           
                        
            
        }
        .onAppear{
            UINavigationBar.appearance().backgroundColor = UIColor.clear
            viewModel.fetchChatHistory(data.id)
        }
        
        
    }
}

#Preview {
    ChatHistoryViewDI().chatHistoryView
}



