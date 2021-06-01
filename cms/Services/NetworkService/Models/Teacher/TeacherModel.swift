//
//  TeacherModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/4/21.
//

import Foundation
struct TeacherModel: Decodable {
    let courseName: String?
    let email: String?
    let endDate: String?
    let name: String?
    let patent: String?
    let patronymic: String?
    let phoneNo: String?
    let position: String?
    let startDate: String?
    let surname: String?
    let table: String?
    let workerID: Int?

    enum CodingKeys: String, CodingKey {
        case courseName
        case email
        case endDate
        case name
        case patent
        case patronymic
        case phoneNo
        case position
        case startDate
        case surname
        case table
        case workerID
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        courseName = try? values.decodeIfPresent(String.self, forKey: .courseName)
        email = try? values.decodeIfPresent(String.self, forKey: .email)
        endDate = try? values.decodeIfPresent(String.self, forKey: .endDate)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        patent = try? values.decodeIfPresent(String.self, forKey: .patent)
        patronymic = try? values.decodeIfPresent(String.self, forKey: .patronymic)
        phoneNo = try? values.decodeIfPresent(String.self, forKey: .phoneNo)
        position = try? values.decodeIfPresent(String.self, forKey: .position)
        startDate = try? values.decodeIfPresent(String.self, forKey: .startDate)
        surname = try? values.decodeIfPresent(String.self, forKey: .surname)
        table = try? values.decodeIfPresent(String.self, forKey: .table)
        workerID = try? values.decodeIfPresent(Int.self, forKey: .workerID)
    }
}
