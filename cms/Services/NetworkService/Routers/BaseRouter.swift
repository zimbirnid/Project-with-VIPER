//
//  BaseRouter.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 12/3/21.
//

import Foundation

protocol BaseRouter {
    var path: String { get }
    var method: String { get }
    var queryParameter: [URLQueryItem]? { get }
    var httpBody: Data? { get }
    var httpHeader: [HttpHeader]? { get }
}

extension BaseRouter {
    
    var userDefaultsService: UserDefaultsService {
        return UserDefaultsService()
    }
    var host: String {
        return "customerms.herokuapp.com"
    }
    var scheme: String {
        return "https"
    }
    func createURLRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryParameter
        guard let url = urlComponents.url else {
            fatalError(URLError(.unsupportedURL).localizedDescription)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = httpBody
        httpHeader?.forEach { (header) in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.field)
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        if let token = userDefaultsService.getToken() {
            urlRequest.setValue(token, forHTTPHeaderField: userDefaultsService.getKey(key: .Authorization))
        }
        return urlRequest
    }
}



