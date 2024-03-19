//
//  LoadingView.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 20/3/24.
//

import SwiftUI
import AlertToast

struct LoadingView: View {
    
    var body: some View {
        
        AlertToast(type: .loading)
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
