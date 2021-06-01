//
//  FilterPageFilterPageInteractorOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 14/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol FilterPageInteractorOutput: class {
    func didGet(statuses: [StatusModel])
    func didGet(courses: [CourseModel])
    func didGet(occupations: [OccupationModel])
    func didGet(positions: [PositionModel])
    func didGet(utms: [UTMModel])
    func didGetFail(message: String)
    func didGetSuccess()
}
