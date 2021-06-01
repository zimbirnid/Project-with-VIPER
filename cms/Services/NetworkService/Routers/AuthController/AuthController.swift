//
//  AuthController.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 12/3/21.
//

import Foundation

enum AuthController: BaseRouter {
    case activate(code: String)
    case confirmAndSendActivation(id: String)
    case rejectAndSendEmail(body: Data)
    case getListOfUserToConfirm
    case getToken(body: Data)
    case forgotPassword(email: String)
    case restore(code: String)
    case setPassword(body: Data)
    case setPassword2(email: String, password: String)
    case createUser(body: Data)
    
    var path: String {
        switch self {
        case let .activate(code):
            return "/register/activate/\(code)"
        case let .confirmAndSendActivation(id):
            return "/register/admin/confirm/\(id)"
        case .rejectAndSendEmail:
            return "/register/admin/reject"
        case .getListOfUserToConfirm:
            return "/register/admin/toConfirm"
        case .getToken:
            return "/register/auth"
        case let .forgotPassword(email):
            return "/register/forgotPassword/\(email)"
        case let .restore(code):
            return "/register/restore/\(code)"
        case .setPassword:
            return "/register/setPassword"
        case .setPassword2:
            return "/register/setPassword2"
        case .createUser:
            return "/register/user"
        }
    }
    var method: String {
        switch self {
        case .activate:
            return HttpMethod.get.value
        case .confirmAndSendActivation:
            return HttpMethod.post.value
        case .rejectAndSendEmail:
            return HttpMethod.post.value
        case .getListOfUserToConfirm:
            return HttpMethod.get.value
        case .getToken:
            return HttpMethod.post.value
        case .forgotPassword:
            return HttpMethod.post.value
        case .restore:
            return HttpMethod.get.value
        case .setPassword:
            return HttpMethod.post.value
        case .setPassword2:
            return HttpMethod.post.value
        case .createUser:
            return HttpMethod.post.value
        }
    }
    var queryParameter: [URLQueryItem]? {
        switch self {
        case .activate:
            return nil
        case .confirmAndSendActivation:
            return nil
        case .rejectAndSendEmail:
            return nil
        case .getListOfUserToConfirm:
            return nil
        case .getToken:
            return nil
        case .forgotPassword:
            return nil
        case .restore:
            return nil
        case .setPassword:
            return nil
        case let .setPassword2(email, password):
            return [
                .init(name: "email", value: email),
                .init(name: "password", value: password)
            ]
        case .createUser:
            return nil
        }
    }
    var httpBody: Data? {
        switch self {
        case .activate:
            return nil
        case .confirmAndSendActivation:
            return nil
        case let .rejectAndSendEmail(body):
            return body
        case .getListOfUserToConfirm:
            return nil
        case let .getToken(body):
            return body
        case .forgotPassword:
            return nil
        case .restore:
            return nil
        case let .setPassword(body):
            return body
        case .setPassword2:
            return nil
        case let .createUser(body):
            return body
        }
    }
    var httpHeader: [HttpHeader]? {
        switch self {
        case .activate:
            return nil
        case .confirmAndSendActivation:
            return nil
        case .rejectAndSendEmail:
            return nil
        case .getListOfUserToConfirm:
            return nil
        case .getToken:
            return nil
        case .forgotPassword:
            return nil
        case .restore:
            return nil
        case .setPassword:
            return nil
        case .setPassword2:
            return nil
        case .createUser:
            return nil
        }
    }
}
