//
//  BlockPopUp.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 23/3/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct BlockPopUp: View {
    @Binding var chatdata : ChatRoomData?
    @Binding var showBlockPopup: Bool

    var body: some View {
        if showBlockPopup {
            ZStack {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.3))
                    .background(Color.clear)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            showBlockPopup = false
                        }
                    }
                
                Rectangle()
                    .frame(width: Constants.Screen.width*0.90, height: 320)
                    .foregroundColor(Color.white)
                
                VStack {
                    HStack {
                        
                        Image("Block", bundle: nil)
                            .padding(.top, 27)
                            
                        
                        Text("Block User")
                            .font(.custom(Constants.Fonts.SansBold, size: 30))
                            .padding(.top, 27)
                        
                        Spacer()
                    }
                    .padding(.leading, 30)
                    
                    HStack {
                        WebImage(url: URL(string: (chatdata?.profilePhoto).safe.contains(".jpeg") ? (chatdata?.profilePhoto).safe : (chatdata?.profilePhoto).safe + ".jpeg"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            
                        
                        Text((chatdata?.fullName).safe)
                            .font(.custom(Constants.Fonts.SansBold, size: 24))
                        
                        Spacer()
                    }
                    .padding(.leading, 30)
                    .padding(.bottom)
                    
                    HStack {
                        Text("Are you sure you want to block this user ? Once blocked they won't be able to send you messages and won't able to match in future.")
                            .font(.custom(Constants.Fonts.SansRegular, size: 16))
                            

                        Spacer()
                    }
                    .padding([.leading, .trailing], 30)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            showBlockPopup = false
                        } label: {
                            Text("CANCEL")
                                .font(.custom(Constants.Fonts.SansRegular, size: 16))
                                .foregroundColor(.black)
                                .padding(.trailing)
                        }
                        
                        Button {
                            showBlockPopup = false
                            
                        } label: {
                            Text("BLOCK")
                                .font(.custom(Constants.Fonts.SansRegular, size: 16))
                                .foregroundColor(Constants.Colors.primary)
                        }
                    }
                    .padding(.top, 10)
                    .padding(.trailing, 40)
                    
                    Spacer()
                }
                .frame(width: Constants.Screen.width*0.90, height: 320)

            }
        } else {
            EmptyView()
        }
        
    }
}

#Preview {
    @State var chatData: ChatRoomData? = ChatRoomData(id: 0, channelName: "", status: "", participants: "", createdAt: 0, blockedBy: 0, fullName: "Shawon Reja", profilePhoto: "https://oho-assets.s3.amazonaws.com/f11a5a49d3834bf68a8030f938bde680", gender: "", lastMessage: "")
    @State var showBlockPopup: Bool = true
    return BlockPopUp(chatdata : $chatData, showBlockPopup: $showBlockPopup)
}
