//
//  AddPagePersonAddPagePersonViewOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 03/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

protocol AddPagePersonViewOutput {

    /**
        @author zhakshylykov-f
        Notify presenter that view is ready
    */

    func viewIsReady()
    func goBack()
    func didGetClient(data: Data)
    func didGetWorker(data: Data)
    func getCourses()
    func getUTMs()
    func getOccuptions()
    func getTargets()
    func getStatuses()
    func getPositions()
}
