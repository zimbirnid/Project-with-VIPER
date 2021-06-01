//
//  FilterPageFilterPageViewInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 14/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol FilterPageViewInput: class {

    /**
        @author zhakshylykov-f
        Setup initial state of the view
    */

    func setupInitialState()
    func didGet(statuses: [StatusModel])
    func didGet(courses: [CourseModel])
    func didGet(occupations: [OccupationModel])
    func didGet(positions: [PositionModel])
    func didGet(utms: [UTMModel])
    func didGetSuccess()
    func didGetFail(message: String)
}
