//
//  AllTeacherModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/4/21.
//

import Foundation
struct AllTeacherModel: Decodable {
    let content: [TeacherModel]?
    let empty: Bool?
    let first: Bool?
    let last: Bool?
    let number: Int?
    let numberOfElements: Int?
    let pageable: PageableModel?
    let size: Int?
    let sort: SortModel?
    let totalElements: Int?
    let totalPages: Int?

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
        content = try values.decodeIfPresent([TeacherModel].self, forKey: .content)
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
