//
//  UTMController.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 13/3/21.
//

import Foundation

enum UTMController: BaseRouter {
    case getUTMs
    case addOccupation(body: Data)
    case getAllByName(name: String)
    case updateOccupationName(body: Data, id: String)
    
    var path: String {
        switch self {
        case .getUTMs:
            return "/utm"
        case .addOccupation:
            return "/utm"
        case .getAllByName(let name):
            return "/utm/name/\(name)"
        case .updateOccupationName(_, let id):
            return "/utm/\(id)"
        }
    }
    
    var method: String {
        switch self {
        case .getUTMs:
            return HttpMethod.get.value
        case .getAllByName:
            return HttpMethod.get.value
        case .addOccupation:
            return HttpMethod.post.value
        case .updateOccupationName:
            return HttpMethod.put.value
        }
    }
    
    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getUTMs:
            return nil
        case .getAllByName:
            return nil
        case .addOccupation:
            return nil
        case .updateOccupationName:
            return nil
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .getUTMs:
            return nil
        case .addOccupation(let body):
            return body
        case .getAllByName:
            return nil
        case .updateOccupationName(let body, _):
            return body
        }
    }
    
    var httpHeader: [HttpHeader]? {
        switch self {
        case .getUTMs:
            return nil
        case .getAllByName:
            return nil
        case .addOccupation:
            return nil
        case .updateOccupationName:
            return nil
        }
    }
}
