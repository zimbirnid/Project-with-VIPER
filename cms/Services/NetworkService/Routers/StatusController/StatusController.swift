//
//  StatusController.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 13/3/21.
//

import Foundation

enum StatusController: BaseRouter {
    case getStatuses
    case addStatus(body: Data)
    case getStatusesDoska
    case getAllByName(name: String)
    case deleteStatusByID(id: String)
    case updateStatusName(id: String, body: Data)
    
    
    var path: String {
        switch self {
        case .getStatuses:
            return "/status"
        case .addStatus:
            return "/status"
        case .getStatusesDoska:
            return "/status/doska"
        case let .getAllByName(name):
            return "/status/name/\(name)"
        case let .deleteStatusByID(id):
            return "/status/\(id)"
        case let .updateStatusName(id, _):
            return "/status/\(id)"
        }
    }
    
    
    var method: String {
        switch self {
        case .getStatuses:
            return HttpMethod.get.value
        case .addStatus:
            return HttpMethod.post.value
        case .getStatusesDoska:
            return HttpMethod.get.value
        case .getAllByName:
            return HttpMethod.get.value
        case .deleteStatusByID:
            return HttpMethod.delete.value
        case .updateStatusName:
            return HttpMethod.put.value
        }
    }
    
    
    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getStatuses:
            return nil
        case .addStatus:
            return nil
        case .getStatusesDoska:
            return nil
        case .getAllByName:
            return nil
        case .deleteStatusByID:
            return nil
        case .updateStatusName:
            return nil
        }
    }
    
    
    var httpBody: Data? {
        switch self {
        case .getStatuses:
            return nil
        case let .addStatus(body):
            return body
        case .getStatusesDoska:
            return nil
        case .getAllByName:
            return nil
        case .deleteStatusByID:
            return nil
        case let .updateStatusName(_, body):
            return body
        }
    }
    
    var httpHeader: [HttpHeader]? {
        switch self {
        case .getStatuses:
            return nil
        case .addStatus:
            return nil
        case .getStatusesDoska:
            return nil
        case .getAllByName:
            return nil
        case .deleteStatusByID:
            return nil
        case .updateStatusName:
            return nil
        }
    }
}
