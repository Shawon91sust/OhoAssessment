//
//  QRCodeView.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 22/3/24.
//

import SwiftUI
import SDWebImageSwiftUI

/// Date QR Code View
struct QRCodeView: View {
    @Environment(\.presentationMode) var presentationMode
    var data: QRCodeObject
    var userName : String
    
    var body: some View {
        
            VStack {
                //Navigation Title
                VStack {
                    HStack(spacing: 0) {
                        
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .frame(width: 18, height: 26)
                                .font(.system(size: 26))
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Constants.Colors.primary)
                                .padding(.leading, 16)
                                .padding(.bottom, 4)
                                
                        }
                        
                        Text("QR Code")
                            .font(.custom(Constants.Fonts.SansBold, size: 35))
                            .padding(.leading, 16)
                            .padding(.bottom, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Divider()
                }
                
                //QRView
                ZStack(alignment: .center) {
                    Rectangle()
                        .frame(width: Constants.Screen.width * 0.85, height: 400)
                        .foregroundColor(Constants.Colors.recipientBubble)
                        .cornerRadius(20)
                    
                    VStack {
                        Text(userName)
                            .font(.custom(Constants.Fonts.SansBold, size: 22))
                        Text("Attendance code")
                            .font(.custom(Constants.Fonts.GrotesqueRegular, size: 24))
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 234, height: 234)
                                .foregroundColor(.white)
                            
                            WebImage(url: URL(string: data.qrCode))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 230, height: 230)
                                .clipped()
                            
                        }.padding(.bottom)
                    }
                }
                .padding(.top, 50)
                
                //BottomText
                HStack {
                    Text("This is your private code. Show this to your server so that we can understand you've arrived for your date. Thanks.")
                        .font(.custom(Constants.Fonts.GrotesqueRegular, size: 20))
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .padding([.leading, .trailing], 30)
                    
                }
                
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    QRCodeViewDI().qrCodeView
}
