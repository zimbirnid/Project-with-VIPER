//
//  BishkekCourseController.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 12/3/21.
//

import Foundation

enum BishkekCourseController: BaseRouter {
    case getAll
    case addNewCourse(body: Data)
    case getByName(name: String)
    case deleteCourse(id: String)
    case getById(id: String)
    case updateCourse(id: String)
    
    
    var path: String {
        switch self {
        case .getAll:
            return "/bishkek/course"
        case .addNewCourse:
            return "/bishkek/course"
        case let .getByName(name):
            return "/bishkek/course/name/\(name)"
        case let .deleteCourse(id):
            return "/bishkek/course/\(id)"
        case let .getById(id):
            return "/bishkek/course/\(id)"
        case let .updateCourse(id):
            return "/bishkek/course/\(id)"
        }
    }
    
    
    var method: String {
        switch self {
        case .getAll:
            return HttpMethod.get.value
        case .addNewCourse:
            return HttpMethod.post.value
        case .getByName:
            return HttpMethod.get.value
        case .deleteCourse:
            return HttpMethod.delete.value
        case .getById:
            return HttpMethod.get.value
        case .updateCourse:
            return HttpMethod.put.value
        }
    }
    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getAll:
            return nil
        case .addNewCourse:
            return nil
        case .getByName:
            return nil
        case .deleteCourse:
            return nil
        case .getById:
            return nil
        case .updateCourse:
            return nil
        }
    }
    var httpBody: Data? {
        switch self {
        case .getAll:
            return nil
        case let .addNewCourse(body):
            return body
        case .getByName:
            return nil
        case .deleteCourse:
            return nil
        case .getById:
            return nil
        case .updateCourse:
            return nil
        }
    }
    var httpHeader: [HttpHeader]? {
        switch self {
        case .getAll:
            return nil
        case .addNewCourse:
            return nil
        case .getByName:
            return nil
        case .deleteCourse:
            return nil
        case .getById:
            return nil
        case .updateCourse:
            return nil
        }
    }
    
}
