//
//  Constant.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 19/3/24.
//

import Foundation
import UIKit

struct Constants {
    static let baseURL         = "https://backend.ohodating.com/api/v1"
    static let socketURL       = "https://chat.backend.ohodating.com"
    static let authToken       = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTE0ODExNDksImlhdCI6MTcxMDYxNzE0OSwic3ViIjo0NjcsInVzZXJfdHlwZSI6Im9obyJ9.j3ef2GbUA0Z7qtsM0jCFWfTH2nPt_CdDRv3LPOHPd2k"
    
    struct Fonts {
        static let circularBold = "CircularStd-Bold"
        static let SansBold = "PTSans-Bold"
        static let SansRegular = "PTSans-Regular"
    }
    
    struct Screen {
        static let width  = UIScreen.main.bounds.width
        static let height = UIScreen.main.bounds.height
    }
    
}
