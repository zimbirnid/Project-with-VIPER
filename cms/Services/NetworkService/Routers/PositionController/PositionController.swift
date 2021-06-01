//
//  PositionController.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 4/4/21.
//

import Foundation

enum PositionController: BaseRouter {
    case getAllPositions
    case deletePositionByID(id: String)
    case updatePosition(id: String, body: Data)
    
    
    var path: String {
        switch self {
        case .getAllPositions:
            return "/position"
        case let .deletePositionByID(id):
            return "/position/\(id)"
        case let .updatePosition(id, _):
            return "/position/\(id)"
        }
    }
    
    
    var method: String {
        switch self {
        case .getAllPositions:
            return HttpMethod.get.value
        case .deletePositionByID:
            return HttpMethod.delete.value
        case .updatePosition:
            return HttpMethod.put.value
        }
    }
    
    
    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getAllPositions:
            return nil
        case .deletePositionByID:
            return nil
        case .updatePosition:
            return nil
        }
    }
    
    
    var httpBody: Data? {
        switch self {
        case .getAllPositions:
            return nil
        case .deletePositionByID:
            return nil
        case let .updatePosition(_, body):
            return body
        }
    }
    
    var httpHeader: [HttpHeader]? {
        switch self {
        case .getAllPositions:
            return nil
        case .deletePositionByID:
            return nil
        case .updatePosition:
            return nil
        }
    }
}
