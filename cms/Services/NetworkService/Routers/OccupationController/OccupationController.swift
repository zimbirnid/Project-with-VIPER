//
//  OccupationController.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 13/3/21.
//

import Foundation

enum OccupationController: BaseRouter {
    case getOccupations
    case getAllByName(name: String)
    case deleteOccupationByID(id: String)
    case updateOccupationName(id: String, body: Data)


    var path: String {
    switch self {
    case .getOccupations:
    return "/occupation"
    case let .getAllByName(name):
    return "/occupation/name/\(name)"
    case let .deleteOccupationByID(id):
    return "/occupation/\(id)"
    case let .updateOccupationName(id, _):
    return "/occupation/\(id)"
    }
    }


    var method: String {
    switch self {
    case .getOccupations:
    return HttpMethod.get.value
    case .getAllByName:
    return HttpMethod.get.value
    case .deleteOccupationByID:
    return HttpMethod.delete.value
    case .updateOccupationName:
    return HttpMethod.put.value
    }
    }
    var queryParameter: [URLQueryItem]? {
    switch self {
    case .getOccupations:
    return nil
    case .getAllByName:
    return nil
    case .deleteOccupationByID:
    return nil
    case .updateOccupationName:
    return nil
    }
    }
    var httpBody: Data? {
    switch self {
    case .getOccupations:
    return nil
    case .getAllByName:
    return nil
    case .deleteOccupationByID:
    return nil
    case let .updateOccupationName(_, body):
    return body
    }
    }
    var httpHeader: [HttpHeader]? {
    switch self {
    case .getOccupations:
    return nil
    case .getAllByName:
    return nil
    case .deleteOccupationByID:
    return nil
    case .updateOccupationName:
    return nil
    }
    }
}
