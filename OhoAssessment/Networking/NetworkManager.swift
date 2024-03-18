//
//  NetworkManager.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 19/3/24.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let manager : Session = {
        let session = Session(configuration : URLSessionConfiguration.af.default)
        return session
    }()
    
    static func request(_ requestConvertible : URLRequestConvertible) -> DataRequest {
        let request = manager.request(requestConvertible)
        return request.validate()
    }
}



