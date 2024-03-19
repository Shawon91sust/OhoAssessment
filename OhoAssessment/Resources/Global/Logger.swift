//
//  Logger.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 20/3/24.
//

import Foundation

final class Logger {
    static func log(_ text: String) {
        #if DEBUG
        print(text)
        #endif
    }
    
    static func log(_ objects: Any...) {
        #if DEBUG
        objects.forEach({ print($0) })
        #endif
    }
    
    private init() { }
}
