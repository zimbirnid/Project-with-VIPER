//
//  PaymentMethodController.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 21/4/21.
//

import Foundation

enum PaymentMethodController: BaseRouter {
    case getAllMethods
    
    var path: String {
        switch self {
        case .getAllMethods:
            return "/method"
        }
    }
    
    var method: String {
        switch self {
        case .getAllMethods:
            return HttpMethod.get.value
        }
    }
    
    var queryParameter: [URLQueryItem]? {
        return nil
    }
    
    var httpBody: Data? {
        return nil
    }
    
    var httpHeader: [HttpHeader]? {
        return nil
    }
}
