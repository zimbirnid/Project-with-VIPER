//
//  FailureModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 12/3/21.
//

import Foundation

struct FailureModel: Decodable {
    var status: Int?
    var error: String?
    var message: String?
    
    enum Keys: String, CodingKey {
        case status
        case error
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        status = try? container.decodeIfPresent(Int.self, forKey: .status)
        error = try? container.decodeIfPresent(String.self, forKey: .error)
        message = try? container.decodeIfPresent(String.self, forKey: .message)
    }
}
