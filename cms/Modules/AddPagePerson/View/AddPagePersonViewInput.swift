//
//  AddPagePersonAddPagePersonViewInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 03/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol AddPagePersonViewInput: class {

    /**
        @author zhakshylykov-f
        Setup initial state of the view
    */

    func setupInitialState()
    func didGet(courses: [CourseModel])
    func didGet(utms: [UTMModel])
    func didGet(targets: [TargetModel])
    func didGet(occupations: [OccupationModel])
    func didGet(statuses: [StatusModel])
    func didGet(positions: [PositionModel])
    func didGetFail(message: String)
    func didGetSuccess()
}
