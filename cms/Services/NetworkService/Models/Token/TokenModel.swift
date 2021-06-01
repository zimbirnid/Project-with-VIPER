//
//  TokenModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 12/3/21.
//

import Foundation

struct TokenModel: Decodable {
    let token : String?
    enum Keys: String, CodingKey {
        case token
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Keys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
}

