//
//  ClientModel.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/4/21.
//

import Foundation
struct ClientModel: Decodable {
    var city: String?
    var clientID: Int?
    var course: CourseModel?
    var dateCreated: String?
    var dateUpdated: String?
    var description: String?
    var email: String?
    var experience: Bool?
    var formName: String?
    var laptop: Bool?
    var leavingReason: LeavingReason?
    var name: String?
    var occupation: OccupationModel?
    var patronymic: String?
    var payments: [PaymentsModel]?
    var phoneNo: String?
    var prepayment: Int?
    var status: StatusModel?
    var surname: String?
    var target: TargetModel?
    var timer: String?
    var utm: UTMModel?

    enum CodingKeys: String, CodingKey {
        case city
        case clientID
        case course
        case dateCreated
        case dateUpdated
        case description
        case email
        case experience
        case formName
        case laptop
        case leavingReason
        case name
        case occupation
        case patronymic
        case payments
        case phoneNo
        case prepayment
        case status
        case surname
        case target
        case timer
        case utm
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        clientID = try values.decodeIfPresent(Int.self, forKey: .clientID)
        course = try values.decodeIfPresent(CourseModel.self, forKey: .course)
        dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
        dateUpdated = try values.decodeIfPresent(String.self, forKey: .dateUpdated)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        experience = try values.decodeIfPresent(Bool.self, forKey: .experience)
        formName = try values.decodeIfPresent(String.self, forKey: .formName)
        laptop = try values.decodeIfPresent(Bool.self, forKey: .laptop)
        leavingReason = try values.decodeIfPresent(LeavingReason.self, forKey: .leavingReason)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        occupation = try values.decodeIfPresent(OccupationModel.self, forKey: .occupation)
        patronymic = try values.decodeIfPresent(String.self, forKey: .patronymic)
        payments = try values.decodeIfPresent([PaymentsModel].self, forKey: .payments)
        phoneNo = try values.decodeIfPresent(String.self, forKey: .phoneNo)
        prepayment = try values.decodeIfPresent(Int.self, forKey: .prepayment)
        status = try values.decodeIfPresent(StatusModel.self, forKey: .status)
        surname = try values.decodeIfPresent(String.self, forKey: .surname)
        target = try values.decodeIfPresent(TargetModel.self, forKey: .target)
        timer = try values.decodeIfPresent(String.self, forKey: .timer)
        utm = try values.decodeIfPresent(UTMModel.self, forKey: .utm)
    }

}
