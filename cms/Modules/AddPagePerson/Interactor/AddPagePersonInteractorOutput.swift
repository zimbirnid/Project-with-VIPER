//
//  AddPagePersonAddPagePersonInteractorOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 03/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol AddPagePersonInteractorOutput: class {
    func didGet(courses: [CourseModel])
    func didGet(utms: [UTMModel])
    func didGet(targets: [TargetModel])
    func didGet(occupations: [OccupationModel])
    func didGet(statuses: [StatusModel])
    func didGet(positions: [PositionModel])
    func didGetSuccess()
    func didGetFail(message: String)
}
