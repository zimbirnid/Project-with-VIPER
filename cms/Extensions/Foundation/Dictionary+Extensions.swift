//
//  Dictionary+Extensions.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 13/3/21.
//

import Foundation

extension Dictionary {
    func toData() -> Data? {
         try? JSONSerialization.data(withJSONObject: self)
    }
}
