//
//  ChatNavigationView.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 20/3/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatNavigationView: View {
    @Environment(\.presentationMode) var presentationMode

    var title: String
    var imageUrl: String
    var onTapQRCode: (() -> Void)?
    var onTapBack: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 0) {
            
            Button {
                onTapBack?()
            } label: {
                Image(systemName: "chevron.backward")
                    .frame(width: 18, height: 26)
                    .font(.system(size: 26))
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Constants.Colors.primary)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
            }
            
            WebImage(url: URL(string: imageUrl.contains(".jpeg") ? imageUrl : imageUrl + ".jpeg")) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "person.circle.fill")
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fill)
                        .font(.system(size: 60))
                        .foregroundColor(Constants.Colors.primary)
                        .clipShape(Circle())
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 60, height: 60, alignment: .center)
                .clipShape(Circle())
            
            
            
            
            Text(title)
                .frame(height: 40)
                .font(.custom(Constants.Fonts.SansBold, size: 22))
                .foregroundColor(.primary)
                .lineLimit(1)
                .padding(.leading, 12)
            
            Spacer()
            
            Button {
                onTapQRCode?()
            } label: {
                Image(systemName: "qrcode")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                    .padding(.trailing)
                    .foregroundColor(Constants.Colors.primary)
            }
        }
        .padding(.bottom, 7)
        
        Divider()
    }
}

#Preview {
    ChatNavigationView(title: "Shawon Rejaul", imageUrl: "https://oho-assets.s3.amazonaws.com/76b555042801437c9bd353debd055a8d")
}
