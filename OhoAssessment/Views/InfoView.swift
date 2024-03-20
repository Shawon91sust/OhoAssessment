//
//  InfoView.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 20/3/24.
//

import SwiftUI

struct InfoView: View {
    
    let infoMessage: String
    
    var body: some View {
        
        Text(infoMessage)
            .font(.title)
            .padding()
        
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(infoMessage: "No room found")
    }
}
