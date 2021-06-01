//
//  SortModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/4/21.
//

import Foundation
struct SortModel: Decodable {
    var empty : Bool?
    var sorted : Bool?
    var unsorted : Bool?

    enum CodingKeys: String, CodingKey {
        case empty
        case sorted
        case unsorted
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        empty = try values.decodeIfPresent(Bool.self, forKey: .empty)
        sorted = try values.decodeIfPresent(Bool.self, forKey: .sorted)
        unsorted = try values.decodeIfPresent(Bool.self, forKey: .unsorted)
    }
}
