//
//  WorkerDetailWorkerDetailViewOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 11/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

protocol WorkerDetailViewOutput {

    /**
        @author zhakshylykov-f
        Notify presenter that view is ready
    */

    func viewIsReady()
    func goBack()
    func getPositions()
    func getCourses()
    func change(id: Int, data: Data)
}
