//
//  ToastView.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 24/3/24.
//


import SwiftUI

struct ToastView: View {
    
    var errorMessage: String
    @Binding var showToast: Bool
    
    var body: some View {
        
//        ZStack {
//            Rectangle()
//                .background(Color.white)
//                .edgesIgnoringSafeArea(.all)
        if showToast {
            ZStack {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.3))
                    .background(Color.clear)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            showToast = false
                        }
                    }
                
                VStack {
                    Spacer()
                    ZStack {
                        Rectangle()
                            .frame(height: 50)
                            .background(Constants.Colors.toastBG)
                            .cornerRadius(40)
                        Text(errorMessage)
                            .font(.custom(Constants.Fonts.SansRegular, size: 18))
                            .foregroundColor(.white)
                        
                    }
                    .padding([.leading, .trailing], 16)
                    .padding(.bottom, 30)
                }
                .edgesIgnoringSafeArea(.all)
                .background(Color.clear)
            }
        }else {
            EmptyView()
        }
            
            
            
                
        //}
        
        
    }
}

#Preview {
    
    @State var showToast: Bool = true
     return ToastView(errorMessage: "No Room Found", showToast: $showToast)
    
}


