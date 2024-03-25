//
//  NetworkError.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 19/3/24.
//

import Foundation
import Alamofire

/// Error class for properly delegating errors responsible for abnormal app behavior created by network calls
struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable {
    let status: Bool
    let error: ErrorInfo
}

// MARK: - Error
struct ErrorInfo: Codable {
    let code: Int
    let message: String
}
