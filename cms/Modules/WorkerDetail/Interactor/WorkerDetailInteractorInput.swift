//
//  WorkerDetailWorkerDetailInteractorInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 11/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol WorkerDetailInteractorInput {
    func getPositions()
    func getCourses()
    func change(id: Int, data: Data)
}
