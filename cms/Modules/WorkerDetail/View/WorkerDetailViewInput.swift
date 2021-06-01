//
//  WorkerDetailWorkerDetailViewInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 11/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol WorkerDetailViewInput: class {

    /**
        @author zhakshylykov-f
        Setup initial state of the view
    */

    func setupInitialState()
    func didGet(positions: [PositionModel])
    func didGet(courses: [CourseModel])
    func didGetFail(message: String)
}
