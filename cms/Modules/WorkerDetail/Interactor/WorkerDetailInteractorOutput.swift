//
//  WorkerDetailWorkerDetailInteractorOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 11/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol WorkerDetailInteractorOutput: class {
    func didGetFail(message: String)
    func didGetSuccess()
    func didGet(positions: [PositionModel])
    func didGet(courses: [CourseModel])
}
