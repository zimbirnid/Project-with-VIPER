//
//  UserController.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 13/3/21.
//

import Foundation

enum UserController: BaseRouter {
    case getAll
    case changePassword(body: Data)
    case getAllByCity(city: String)
    case getByEmail(email: String)
    case profile
    
    var path: String {
        switch self {
        case .getAll:
            return "/user"
        case .changePassword:
            return "/user/changePassword"
        case let .getAllByCity(city):
            return "/user/city/\(city)"
        case let .getByEmail(email):
            return "/user/email/\(email)"
        case .profile:
            return "/user/profile"
        }
    }
    
    
    var method: String {
        switch self {
        case .getAll:
            return HttpMethod.get.value
        case .changePassword:
            return HttpMethod.post.value
        case .getAllByCity:
            return HttpMethod.get.value
        case .getByEmail:
            return HttpMethod.get.value
        case .profile:
            return HttpMethod.get.value
        }
    }
    
    
    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getAll:
            return nil
        case .changePassword:
            return nil
        case .getAllByCity:
            return nil
        case .getByEmail:
            return nil
        case .profile:
            return nil
        }
    }
    
    
    var httpBody: Data? {
        switch self {
        case .getAll:
            return nil
        case let .changePassword(body):
            return body
        case .getAllByCity:
            return nil
        case .getByEmail:
            return nil
        case .profile:
            return nil
        }
    }
    var httpHeader: [HttpHeader]? {
        switch self {
        case .getAll:
            return nil
        case .changePassword:
            return nil
        case .getAllByCity:
            return nil
        case .getByEmail:
            return nil
        case .profile:
            return nil
        }
    }
}
