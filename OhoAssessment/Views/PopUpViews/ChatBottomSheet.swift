//
//  ChatBottomSheet.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 23/3/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatBottomSheet: View {
    @Binding var chatdata : ChatRoomData?
    @Binding var showChatBottomSheet: Bool
    var onBlock: ()-> Void
    var onReport: ()-> Void
    
    var body: some View {
        if showChatBottomSheet {
            ZStack {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.3))
                    .background(Color.clear)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            showChatBottomSheet = false
                        }
                    }
                
                
                
                VStack(spacing : 0) {
                    Spacer()
                    HStack {
                        Image("BlockAnother", bundle: nil)
                        Text("Block")
                            .font(.custom(Constants.Fonts.SansBold, size: 30))
                    }
                    .frame(width: Constants.Screen.width, height: 70)
                    .background(.white)
                    .onTapGesture {
                        onBlock()
                    }
                    .cornerRadius(16.0, corners: [.topLeft, .topRight])
                    
                    Divider()
                    
                    HStack {
                        Image("ReportAnother", bundle: nil)
                        Text("Report")
                            .font(.custom(Constants.Fonts.SansBold, size: 30))
                    }
                    .frame(width: Constants.Screen.width, height: 60)
                    .background(.white)
                    .onTapGesture {
                        onReport()
                    }
                    
                    Rectangle()
                        .background(.white)
                        .foregroundColor(.white)
                        .frame(height : 20)
                }
                .edgesIgnoringSafeArea(.all)
            }
        } else {
            EmptyView()
        }
        
    }
}

#Preview {
    @State var chatData: ChatRoomData? = ChatRoomData(id: 0, channelName: "", status: "", participants: "", createdAt: 0, blockedBy: 0, fullName: "Shawon Reja", profilePhoto: "https://oho-assets.s3.amazonaws.com/f11a5a49d3834bf68a8030f938bde680", gender: "", lastMessage: "")
    @State var showChatBottomSheet: Bool = true
    return ChatBottomSheet(chatdata : $chatData, showChatBottomSheet: $showChatBottomSheet) {
        
    } onReport: {}
}
