//
//  ReportPopUp.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 23/3/24.
//

import SwiftUI
import SDWebImageSwiftUI

/// Pop up view that shows to report user
struct ReportPopUp: View {
    @Binding var chatdata : ChatRoomData?
    @Binding var showReportPopup: Bool
    
    @State var reportCause = [
        "Impersonation": false,
        "Inappropriate Behavior": false,
        "Threats or Violence": false
    ]

    var body: some View {
        if showReportPopup {
            ZStack {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.3))
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            showReportPopup = false
                        }
                    }
                
                Rectangle()
                    .frame(width: Constants.Screen.width*0.90, height: Constants.Screen.height*0.60)
                    .foregroundColor(Color.white)
                
                VStack {
                    HStack {
                        
                        Image("Report", bundle: nil)
                            .padding(.top, 27)
                            
                        
                        Text("Report User")
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
                    
                    
                    VStack {
                        Text("Please select your reasons for reporting this user. Once someone's profile is reported we verify and take necessary measures against them.")
                            .font(.custom(Constants.Fonts.SansRegular, size: 16))
                            .fixedSize(horizontal: false, vertical: true)
                            
                            
                    }
                    .padding([.leading, .trailing], 26)
                    .padding(.top, 4)
                    
                    VStack {
                        VStack{
                            ForEach(Array(reportCause.keys), id: \.self) { key in
                                HStack {
                                    Image(systemName: reportCause[key] ?? false ? "checkmark.square.fill" : "square")
                                        .foregroundColor(reportCause[key] ?? false ? Constants.Colors.primary : .black)
                                    
                                    Text("\(key)")
                                        .font(.custom(Constants.Fonts.SansRegular, size: 16))
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                                .padding(.leading, 8)
                                .onTapGesture {
                                    reportCause[key]?.toggle()
                                }
                            }
                            .padding(8)
                        }
                        .padding([.top, .bottom], 10)
                    }
                    .background(Constants.Colors.recipientBubble)
                    .cornerRadius(16.0)
                    .padding([.leading, .trailing], 28)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            showReportPopup = false
                        } label: {
                            Text("CANCEL")
                                .font(.custom(Constants.Fonts.SansRegular, size: 16))
                                .foregroundColor(.black)
                                .padding(.trailing)
                        }
                        
                        Button {
                            showReportPopup = false
                        } label: {
                            Text("REPORT")
                                .font(.custom(Constants.Fonts.SansRegular, size: 16))
                                .foregroundColor(Constants.Colors.primary)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.trailing, 40)
                    
                    Spacer()
                }
                .frame(width: Constants.Screen.width*0.90, height: 350)

            }
        } else {
            EmptyView()
        }
        
    }
}


#Preview {
    @State var chatData: ChatRoomData? = ChatRoomData(id: 0, channelName: "", status: "", participants: "", createdAt: 0, blockedBy: 0, fullName: "Shawon Reja", profilePhoto: "https://oho-assets.s3.amazonaws.com/f11a5a49d3834bf68a8030f938bde680", gender: "", lastMessage: "")
    @State var showReportPopup: Bool = true
    return ReportPopUp(chatdata : $chatData, showReportPopup: $showReportPopup)
}
