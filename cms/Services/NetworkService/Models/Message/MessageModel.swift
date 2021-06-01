//
//  MessageModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 13/3/21.
//

import Foundation

struct MessageModel: Decodable {
    var message: String?
    
    enum Keys: String, CodingKey {
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        message = try? container.decodeIfPresent(String.self, forKey: .message)
    }
}
