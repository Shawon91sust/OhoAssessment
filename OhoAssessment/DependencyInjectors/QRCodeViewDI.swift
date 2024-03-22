//
//  QRCodeViewDI.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 22/3/24.
//

import Foundation

struct QRCodeViewDI {

    var qrCodeView: QRCodeView {
        QRCodeView(data: qrCodeData, userName: userName)
    }
    
    private var qrCodeData: QRCodeObject {
        QRCodeObject(qrCode: "https://oho-match-qr-codes.s3.amazonaws.com/467_130.jpg", matchID: 130)
    }
    
    private var userName: String = "Shawon Rejaul"
     
}
