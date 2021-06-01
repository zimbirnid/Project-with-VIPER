//
//  PaymentsModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/4/21.
//

import Foundation
struct PaymentsModel: Decodable {
    let course: CourseModel?
    let dateCreated: String?
    let dateUpdated: String?
    let done: Bool?
    let id: Int?
    let method: MethodModel?
    let month: String?
    let price: Int?

    enum CodingKeys: String, CodingKey {
        case course
        case dateCreated
        case dateUpdated
        case done
        case id
        case method
        case month
        case price
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        course = try? values.decodeIfPresent(CourseModel.self, forKey: .course)
        dateCreated = try? values.decodeIfPresent(String.self, forKey: .dateCreated)
        dateUpdated = try? values.decodeIfPresent(String.self, forKey: .dateUpdated)
        done = try? values.decodeIfPresent(Bool.self, forKey: .done)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        method = try? values.decodeIfPresent(MethodModel.self, forKey: .method)
        month = try? values.decodeIfPresent(String.self, forKey: .month)
        price = try? values.decodeIfPresent(Int.self, forKey: .price)
    }
}
