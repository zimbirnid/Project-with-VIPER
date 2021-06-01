//
//  OshCourseController.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 13/3/21.
//

import Foundation

enum OshCourseController: BaseRouter {
    case getAll
    case addNewCourse(body: Data)
    case getByName(name: String)
    case deleteCourse(id: String)
    case getById(id: String)
    case updateCourse(body: Data, id: String)
    
    var path: String {
        switch self {
        case .getAll:
            return "/osh/course"
        case .addNewCourse:
            return "/osh/course"
        case .getByName(let name):
            return "/osh/course/name/\(name)"
        case .deleteCourse(let id):
            return "/osh/course/\(id)"
        case .getById(let id):
            return "/osh/course/\(id)"
        case .updateCourse(_, let id):
            return "/osh/course/\(id)"
        }
    }
    
    var method: String {
        switch self {
        case .getAll:
            return HttpMethod.get.value
        case .getByName:
            return HttpMethod.get.value
        case .getById:
            return HttpMethod.get.value
        case .addNewCourse:
            return HttpMethod.post.value
        case .deleteCourse:
            return HttpMethod.delete.value
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
        case .addNewCourse(let body):
            return body
        case .getByName:
            return nil
        case .deleteCourse:
            return nil
        case .getById:
            return nil
        case .updateCourse(let body, _):
            return body
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
