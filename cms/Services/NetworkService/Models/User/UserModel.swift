//
//  UserModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/4/21.
//

import Foundation
struct UserModel: Decodable {
    let activationCode: String?
    let active: Bool?
    let city: String?
    let confirmed: Bool?
    let dateCreated: String?
    let dateUpdated: String?
    let email: String?
    let id: Int?
    let name: String?
    let patronymic: String?
    let phoneNo: String?
    let position: PositionModel?
    let role: RoleModel?
    let surname: String?

    enum CodingKeys: String, CodingKey {
        case activationCode
        case active
        case city
        case confirmed
        case dateCreated
        case dateUpdated
        case email
        case id
        case name
        case patronymic
        case phoneNo
        case position
        case role
        case surname
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        activationCode = try values.decodeIfPresent(String.self, forKey: .activationCode)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        confirmed = try values.decodeIfPresent(Bool.self, forKey: .confirmed)
        dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
        dateUpdated = try values.decodeIfPresent(String.self, forKey: .dateUpdated)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        patronymic = try values.decodeIfPresent(String.self, forKey: .patronymic)
        phoneNo = try values.decodeIfPresent(String.self, forKey: .phoneNo)
        position = try values.decodeIfPresent(PositionModel.self, forKey: .position)
        role = try values.decodeIfPresent(RoleModel.self, forKey: .role)
        surname = try values.decodeIfPresent(String.self, forKey: .surname)
    }
}
