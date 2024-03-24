//
//  ChatRoomCell.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 20/3/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatRoomCell: View {
    var data:ChatRoomData
    var onTap: ()-> Void
    var onLongTap: ()-> Void
    
    var body: some View {
        
        VStack {
            HStack(spacing : 16) {
                WebImage(url: URL(string: data.profilePhoto.contains(".jpeg") ? data.profilePhoto : data.profilePhoto + ".jpeg"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding(.leading)
                
                
                VStack(spacing: 0) {
                    HStack {
                        Text(data.fullName)
                            .font(.custom(Constants.Fonts.SansBold, size: 22))
                            .foregroundColor(.black)
                            .lineLimit(1)
                            .padding(.bottom, 8)
                        Spacer()
                    }
                    .frame(maxWidth : .infinity)
                    
                    HStack {
                        Text(data.lastMessage)
                            .font(.custom(Constants.Fonts.SansRegular, size: 22))
                            .foregroundColor(.black)
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    .frame(maxWidth : .infinity)
                    
                }
            }
            .frame(width: Constants.Screen.width)
            .padding([.leading, .trailing, .top, .bottom])
            .onTapGesture {
                onTap()
            }
            .onLongPressGesture(perform: {
                onLongTap()
            })
            
            
            Divider()
            
            
        }.frame(width :Constants.Screen.width, height : 146)
    }
}

#Preview {
    ChatRoomCell(
        data: ChatRoomData(
            id: 0,
            channelName: "7a4c2e00-7ae6-4983-9e1e-8c5881d8af9d",
            status: "",
            participants: "",
            createdAt: 1,
            blockedBy: 1,
            fullName: "Jane Doe",
            profilePhoto: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d",
            gender: "",
            lastMessage: "I'm so glad to hear that you enjoyed our time together! I had a great time too. You're such a genuinely nice person, and I felt really comfortable with you. Looking forward to more adventures together! 😊")
    ) {
        
    } onLongTap: {
        
    }
}
