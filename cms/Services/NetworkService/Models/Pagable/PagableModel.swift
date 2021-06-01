//
//  PagableModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/4/21.
//

import Foundation
struct PageableModel: Decodable {
    var offset: Int?
    var pageNumber: Int?
    var pageSize: Int?
    var paged: Bool?
    var sort: SortModel?
    var unpaged: Bool?

    enum CodingKeys: String, CodingKey {
        case offset
        case pageNumber
        case pageSize
        case paged
        case sort
        case unpaged
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        pageNumber = try values.decodeIfPresent(Int.self, forKey: .pageNumber)
        pageSize = try values.decodeIfPresent(Int.self, forKey: .pageSize)
        paged = try values.decodeIfPresent(Bool.self, forKey: .paged)
        sort = try values.decodeIfPresent(SortModel.self, forKey: .sort)
        unpaged = try values.decodeIfPresent(Bool.self, forKey: .unpaged)
    }
}
