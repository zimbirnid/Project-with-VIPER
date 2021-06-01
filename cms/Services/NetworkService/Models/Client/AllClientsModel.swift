//
//  AllClientsModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/4/21.
//

import Foundation
struct AllClientsModel: Decodable {
    var content: [ClientModel]?
    var empty: Bool?
    var first: Bool?
    var last: Bool?
    var number: Int?
    var numberOfElements: Int?
    var pageable: PageableModel?
    var size: Int?
    var sort: SortModel?
    var totalElements: Int?
    var totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case content
        case empty
        case first
        case last
        case number
        case numberOfElements
        case pageable
        case size
        case sort
        case totalElements
        case totalPages
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        content = try values.decodeIfPresent([ClientModel].self, forKey: .content)
        empty = try values.decodeIfPresent(Bool.self, forKey: .empty)
        first = try values.decodeIfPresent(Bool.self, forKey: .first)
        last = try values.decodeIfPresent(Bool.self, forKey: .last)
        number = try values.decodeIfPresent(Int.self, forKey: .number)
        numberOfElements = try values.decodeIfPresent(Int.self, forKey: .numberOfElements)
        pageable = try values.decodeIfPresent(PageableModel.self, forKey: .pageable)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        sort = try values.decodeIfPresent(SortModel.self, forKey: .sort)
        totalElements = try values.decodeIfPresent(Int.self, forKey: .totalElements)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
    }
}
