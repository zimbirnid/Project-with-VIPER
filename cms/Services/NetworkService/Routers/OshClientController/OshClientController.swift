//
//  OshClientController.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 13/3/21.
//

import Foundation

enum OshClientController: BaseRouter {
    case getAll(page: Int, size: Int)
    case addClient(body: Data)
    case getFile
    case filter(status_id: String?, course_id: String?, occupation_id: String?, utm_id: String?, page: String?, size: String?, field: String?)
    case importFile
    case search(page: String?, size: String?, field: String?)
    case getAllByStatus(status_id: String)
    case getClientsWithExpiredTimer
    case changeCity(client_id: String)
    case addPayment(client_id: String, body: Data)
    case deletePayment(client_id: String, payment_id: String)
    case editPayment(client_id: String, payment_id: String, body: Data)
    case changeStatus(client_id: String, status_id: String)
    case deleteClient(id: String)
    case getById(id: String)
    case updateClient(id: String, body: Data)
    
    var path: String {
        switch self {
        case .getAll:
            return "/osh/client"
        case .addClient:
            return "/osh/client"
        case .getFile:
            return "/osh/client/export"
        case .filter:
            return "/osh/client/filter"
        case .importFile:
            return "/osh/client/import"
        case .search:
            return "/osh/client/search"
        case let .getAllByStatus(status_id):
            return "/osh/client/status/\(status_id)"
        case let .changeCity(client_id):
            return "/osh/client/\(client_id)/city"
        case let .addPayment(client_id, _):
            return "/osh/client/\(client_id)/payment"
        case let .deletePayment(client_id, payment_id):
            return "/osh/client/\(client_id)/payment/\(payment_id)"
        case let .editPayment(client_id, payment_id, _):
            return "/osh/client/\(client_id)/payment/\(payment_id)"
        case let .changeStatus(client_id, status_id):
            return "/osh/client/\(client_id)/status/\(status_id)"
        case let .deleteClient(id):
            return "/osh/client/\(id)"
        case let .getById(id):
            return "/osh/client/\(id)"
        case let .updateClient(id, _):
            return "/osh/client/\(id)"
        case .getClientsWithExpiredTimer:
            return "/osh/client/timer"
        }
    }
    
    var method: String {
        switch self {
        case .getAll:
            return HttpMethod.get.value
        case .addClient:
            return HttpMethod.post.value
        case .getFile:
            return HttpMethod.get.value
        case .filter:
            return HttpMethod.get.value
        case .importFile:
            return HttpMethod.post.value
        case .search:
            return HttpMethod.get.value
        case .getAllByStatus:
            return HttpMethod.get.value
        case .changeCity:
            return HttpMethod.put.value
        case .addPayment:
            return HttpMethod.post.value
        case .deletePayment:
            return HttpMethod.delete.value
        case .editPayment:
            return HttpMethod.put.value
        case .changeStatus:
            return HttpMethod.put.value
        case .deleteClient:
            return HttpMethod.delete.value
        case .getById:
            return HttpMethod.get.value
        case .updateClient:
            return HttpMethod.put.value
        case .getClientsWithExpiredTimer:
            return HttpMethod.get.value
        }
    }
    
    var queryParameter: [URLQueryItem]? {
        switch self {
        case let .getAll(page, size):
            return [
                .init(name: "page", value: "\(page)"),
                .init(name: "size", value: "\(size)")
            ]
        case .addClient:
            return nil
        case .getFile:
            return nil
        case let .filter(status_id, course_id, occupation_id, utm_id, page, size, _):
            var a = [URLQueryItem]()
            if let text = status_id?.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: ""), !text.isEmpty {
                a.append(.init(name: "status_id", value: text))
            }
            if let text = course_id?.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: ""), !text.isEmpty {
                a.append(.init(name: "course_id", value: text))
            }
            if let text = occupation_id?.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: ""), !text.isEmpty {
                a.append(.init(name: "occupation_id", value: text))
            }
            if let text = utm_id?.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: ""), !text.isEmpty {
                a.append(.init(name: "utm_id", value: text))
            }
            a.append(contentsOf: [.init(name: "page", value: page),.init(name: "size", value: size)])
            return a
        case .importFile:
            return nil
        case .search:
            return nil
        case .getAllByStatus:
            return nil
        case .changeCity:
            return nil
        case .addPayment:
            return nil
        case .deletePayment:
            return nil
        case .editPayment:
            return nil
        case .changeStatus:
            return nil
        case .deleteClient:
            return nil
        case .getById:
            return nil
        case .updateClient:
            return nil
        case .getClientsWithExpiredTimer:
            return nil
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .getAll:
            return nil
        case let .addClient(body):
            return body
        case .getFile:
            return nil
        case .filter:
            return nil
        case .importFile:
            return nil
        case .search:
            return nil
        case .getAllByStatus:
            return nil
        case .changeCity:
            return nil
        case let .addPayment(_,body):
            return body
        case .deletePayment:
            return nil
        case let .editPayment(_,_,body):
            return body
        case .changeStatus:
            return nil
        case .deleteClient:
            return nil
        case .getById:
            return nil
        case let .updateClient(_, body):
            return body
        case .getClientsWithExpiredTimer:
            return nil
        }
    }
    
    var httpHeader: [HttpHeader]? {
        switch self {
        case .getAll:
            return nil
        case .addClient:
            return nil
        case .getFile:
            return nil
        case .filter:
            return nil
        case .importFile:
            return nil
        case .search:
            return nil
        case .getAllByStatus:
            return nil
        case .changeCity:
            return nil
        case .addPayment:
            return nil
        case .deletePayment:
            return nil
        case .editPayment:
            return nil
        case .changeStatus:
            return nil
        case .deleteClient:
            return nil
        case .getById:
            return nil
        case .updateClient:
            return nil
        case .getClientsWithExpiredTimer:
            return nil
        }
    }
}
