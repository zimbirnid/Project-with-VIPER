//
//  CreateUserModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/4/21.
//

import Foundation

struct CreateUserModel: Codable {
    var city: String?
    var email: String?
    var name: String?
    var password: String?
    var patronymic: String?
    var phoneNo: String?
    var position: String?
    var surname: String?
}
