//
//  MethodModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/4/21.
//

import Foundation
struct MethodModel: Decodable {
    let dateCreated: String?
    let dateUpdated: String?
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case dateCreated
        case dateUpdated
        case id
        case name
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
        dateUpdated = try values.decodeIfPresent(String.self, forKey: .dateUpdated)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
