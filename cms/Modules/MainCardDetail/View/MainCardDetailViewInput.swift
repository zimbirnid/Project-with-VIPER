//
//  MainCardDetailMainCardDetailViewInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 23/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol MainCardDetailViewInput: class {

    /**
        @author zhakshylykov-f
        Setup initial state of the view
    */

    func setupInitialState()
    func didGet(statuses: [StatusModel])
    func didGet(courses: [CourseModel])
    func didGet(sources: [UTMModel])
    func didGet(targets: [TargetModel])
    func didGet(occupations: [OccupationModel])
    func didGetFail(message: String)
    func didGetSuccess()
}
