//
//  StatusCode.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 12/3/21.
//

import Foundation

enum StatusCode {
    // success
    case ok
    case created
    
    // client fail
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case methodNotAllowed
    case gone
    case unsupportedMediaType
    case internalServerError
    
    // server fail
    case notImplemented
    case serviceUnavailable
    
    var code: Int {
        switch self {
        case .ok:
            return 200
        case .created:
            return 201
        case .badRequest:
            return 400
        case .unauthorized:
            return 401
        case .forbidden:
            return 403
        case .notFound:
            return 404
        case .methodNotAllowed:
            return 405
        case .gone:
            return 410
        case .unsupportedMediaType:
            return 415
        case .internalServerError:
            return 500
        case .notImplemented:
            return 501
        case .serviceUnavailable:
            return 503
        }
    }
}
