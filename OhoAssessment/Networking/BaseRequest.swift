//
//  BaseRequestConvertible.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 19/3/24.
//

import Foundation
import Alamofire

/// BaseRequest interface to facilitate api requests - Injects common configurations to api requests
protocol BaseRequest: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    
    var method: HTTPMethod { get }
    var queries: [String: String]? { get }
    var params: Parameters? { get }
    
    var headers: HTTPHeaders? { get }
    
}

extension BaseRequest {

    func buildURL() -> Result<URL, URLError> {
        
        let url = baseURL + path
        
        guard var urlComponents = URLComponents(string: url) else {
            return .failure(URLError(.badURL))
        }
        
        urlComponents.queryItems = queries?.map { URLQueryItem(name: $0, value: $1) }
        
        guard let finalURL = urlComponents.url
        else {
            return .failure(URLError(.badURL))
        }

        return .success(finalURL)
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let urlResult = buildURL()
        let fullURL: URL
        
        switch urlResult {
        case .success(let url):
            fullURL = url
        case .failure(let error):
            throw error
        }
        
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 30
        
        headers?.forEach({ urlRequest.addValue($0.value, forHTTPHeaderField: $0.name) })
        
        switch method {
        case .get:
            return urlRequest
        default:
            print(method.rawValue)
        }
        
        let encoder = JSONEncoding.default
        urlRequest = try encoder.encode(urlRequest, with: params)
        return urlRequest
    }
}
