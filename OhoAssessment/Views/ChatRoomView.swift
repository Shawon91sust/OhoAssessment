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
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
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
                                    
                                } onLongTap: {
                                    
                                }

                            }
                        }
                    }
                }
                
                
//                switch viewModel.state {
//                case .idle:
//                    IdleView()
//                        .onAppear {
//                            viewModel.listenToSearch()
//                        }
//                case .loading:
//                    ProgressView()
//                case .failed(let error):
//                    ErrorView(error: error)
//                case .loaded(let repos):
//                    List {
//                        // go back button
//                        if viewModel.currentPage > 1 {
//                            Button {
//                                viewModel.currentPage -= 1
//                                viewModel.fetchRepos()
//                            } label: {
//                                Text("Go back")
//                            }
//                        }
//                        // main list
//                        ForEach(repos) { repo in
//                            NavigationLink(destination: WebView(url: URL(string: repo.htmlURL)!)) {
//                                RepoListRow(repo: repo)
//                            }
//                            .isDetailLink(false)
//                        }
//                        
//
//                    }
//                } 
//
//            }
                
                Spacer()
            }
        }
        .onAppear{
            viewModel.fetchChatRooms()
        }
        
    }
}

#Preview {
    ChatRoomViewDI().chatRoomView
}
