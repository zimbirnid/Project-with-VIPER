//
//  PaymentsPostModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/4/21.
//

import Foundation
struct PaymentsPostModel: Codable {
  var done: Bool?
  var methodID: Int?
  var month: String?
  var price: Int?
}
