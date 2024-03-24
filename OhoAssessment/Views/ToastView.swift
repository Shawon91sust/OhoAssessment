//
//  ToastView.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 24/3/24.
//

import SwiftUI

struct ToastView: View {
    let errorTitle: String

    var body: some View {
        
        RoundedRectangle(cornerRadius: 40)
            .foregroundColor(Color.black.opacity(0.7))
            .frame(height: 50)
            .padding()
            .overlay {

                VStack {
                    Text(errorTitle)
                        .font(.custom(Constants.Fonts.SansRegular, size: 18))
                        .foregroundColor(.white)
                }
            }
            
        
    }
}

#Preview {
//    @State var errorMessage : String = "Test Error"
//    @State var showToast: Bool = true
//     return ToastView(errorMessage: $errorMessage, showToast: $showToast)
    
    return ToastView(errorTitle: "Test Error")
                
    
}


