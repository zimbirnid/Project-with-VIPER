//
//  WorkerDetailWorkerDetailPresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 11/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

class WorkerDetailPresenter {
    weak var view: WorkerDetailViewInput!
    var interactor: WorkerDetailInteractorInput!
    var router: WorkerDetailRouterInput!
}


// MARK: - Module Input

extension WorkerDetailPresenter: WorkerDetailModuleInput {}


// MARK: - View Output

extension WorkerDetailPresenter: WorkerDetailViewOutput {
    func change(id: Int, data: Data) {
        interactor.change(id: id, data: data)
    }
    
    func getPositions() {
        interactor.getPositions()
    }
    
    func getCourses() {
        interactor.getCourses()
    }
    
    func goBack() {
        router.goBack()
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension WorkerDetailPresenter: WorkerDetailInteractorOutput {
    func didGetFail(message: String) {
        view.didGetFail(message: message)
    }
    
    func didGetSuccess() {
        router.goBack()
    }
   
    func didGet(positions: [PositionModel]) {
        view.didGet(positions: positions)
    }
    
    func didGet(courses: [CourseModel]) {
        view.didGet(courses: courses)
    }
}
