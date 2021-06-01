//
//  StatusModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/4/21.
//

import Foundation
struct StatusModel: Decodable {
    var dateCreated: String?
    var dateUpdated: String?
    var doska: Bool?
    var id: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case dateCreated
        case dateUpdated
        case doska
        case id
        case name
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
        dateUpdated = try values.decodeIfPresent(String.self, forKey: .dateUpdated)
        doska = try values.decodeIfPresent(Bool.self, forKey: .doska)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
