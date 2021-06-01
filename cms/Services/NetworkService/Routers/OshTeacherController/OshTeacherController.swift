//
//  OshTeacherController.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 13/3/21.
//

import Foundation

enum OshTeacherController: BaseRouter {
    case getAll(page: String, size: String)
    case addNewTeacher(body: Data)
    case filter(position: String?, courseID: String?, page: String?, size: String?, field: String?)
    case search(page: String, size: String, field: String)
    case deleteTeacher(id: String)
    case updateTeacher(id: String, body: Data)
    
    var path: String {
        switch self {
        case .getAll:
            return "/osh/worker"
        case .addNewTeacher:
            return "/osh/worker"
        case .filter:
            return "/osh/worker/filter"
        case .search:
            return "/osh/worker/search"
        case let .deleteTeacher(id):
            return "/osh/worker/\(id)"
        case let .updateTeacher(id, _):
            return "/osh/worker/\(id)"
        }
    }
    
    var method: String {
        switch self {
        case .getAll:
            return HttpMethod.get.value
        case .addNewTeacher:
            return HttpMethod.post.value
        case .filter:
            return HttpMethod.get.value
        case .search:
            return HttpMethod.get.value
        case .deleteTeacher:
            return HttpMethod.delete.value
        case .updateTeacher:
            return HttpMethod.put.value
        }
    }
    
    var queryParameter: [URLQueryItem]? {
        switch self {
        case let .getAll(page, size):
            return [
                .init(name: "page", value: page),
                .init(name: "size", value: size)
            ]
        case .addNewTeacher:
            return nil
        case let .filter(position, courseID, page, size, _):
            var a = [URLQueryItem]()
            if let text = courseID?.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: ""), !text.isEmpty {
                a.append(.init(name: "courseID", value: text))
            }
            if let text = position?.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: ""), !text.isEmpty {
                a.append(.init(name: "position", value: text))
            }
            a.append(contentsOf: [.init(name: "page", value: page),.init(name: "size", value: size)])
            return a
        case let .search(page, size, field):
            return [
                .init(name: "page", value: page),
                .init(name: "size", value: size),
                .init(name: "field", value: field),
            ]
        case .deleteTeacher:
            return nil
        case .updateTeacher:
            return nil
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .getAll:
            return nil
        case let .addNewTeacher(body):
            return body
        case .filter:
            return nil
        case .search:
            return nil
        case .deleteTeacher:
            return nil
        case let .updateTeacher(_, body):
            return body
        }
    }
    
    var httpHeader: [HttpHeader]? {
        switch self {
        case .getAll:
            return nil
        case .addNewTeacher:
            return nil
        case .filter:
            return nil
        case .search:
            return nil
        case .deleteTeacher:
            return nil
        case .updateTeacher:
            return nil
        }
    }
}
