//
//  MainCardDetailMainCardDetailInteractorOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 23/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol MainCardDetailInteractorOutput: class {
    func didGet(statuses: [StatusModel])
    func didGet(courses: [CourseModel])
    func didGet(sources: [UTMModel])
    func didGet(occupations: [OccupationModel])
    func didGet(targets: [TargetModel])
    func didGetFail(message: String)
    func pop()
    func didGetSuccess()
}
