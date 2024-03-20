//
//  MessageRow.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 21/3/24.
//

import SwiftUI

struct MessageRow: View {
    var message: ChatMessage
    
    var body: some View {
        
        if message.sender == Constants.userId {
            HStack {
                Spacer()
                Text(message.body)
                    .font(.custom(Constants.Fonts.SansRegular, size: 18))
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .background (
                        LinearGradient(gradient: Gradient(colors: [Constants.Colors.userBubble, Constants.Colors.userBubble, Constants.Colors.userBubbleSecondary]), startPoint: .top, endPoint: .bottom)
                            .cornerRadius(30)
                            .padding(.trailing, 10)
                            .padding([.top, .bottom], 5)
                            
                    )
                    
            }.padding(.leading)
        } else {
            HStack {
                Text(message.body)
                    .font(.custom(Constants.Fonts.SansRegular, size: 18))
                    .padding()
                    .background(Constants.Colors.recipientBubble.opacity(0.50))
                    .foregroundColor(.black)
                    .cornerRadius(30)
                Spacer()
            }.padding(.trailing)
        }
        
    }
}


#Preview {
    MessageRow(message: ChatMessage(id: 1, body: "Hi John, Glad we matched. Your profile looks amazing! Looking forward to our date at Binge Bar DC - 506 H St NE LL, Washington, DC 20002 on Friday at 7:00 pm and getting to know you more :)", sender: 467, chatID: 0, chatType: "", createdAt: 00))
}
