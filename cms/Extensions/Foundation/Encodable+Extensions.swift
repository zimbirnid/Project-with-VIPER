//
//  Encodable+Extensions.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 2/4/21.
//

import Foundation

extension Encodable {
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
