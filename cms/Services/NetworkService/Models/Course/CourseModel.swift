//
//  CourseModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/4/21.
//

import Foundation

struct CourseModel: Decodable {
    var dateCreated: String?
    var dateUpdated: String?
    var id: Int?
    var name: String?
    var price: Int?

    enum CodingKeys: String, CodingKey {
        case dateCreated
        case dateUpdated
        case id
        case name
        case price
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
        dateUpdated = try values.decodeIfPresent(String.self, forKey: .dateUpdated)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
    }
}
