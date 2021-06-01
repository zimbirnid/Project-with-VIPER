//
//  AddPagePersonAddPagePersonPresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 03/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

class AddPagePersonPresenter {
    weak var view: AddPagePersonViewInput!
    var interactor: AddPagePersonInteractorInput!
    var router: AddPagePersonRouterInput!
}


// MARK: - Module Input

extension AddPagePersonPresenter: AddPagePersonModuleInput {}


// MARK: - View Output

extension AddPagePersonPresenter: AddPagePersonViewOutput {
    
    func getPositions() {
        interactor.getPositions()
    }
    
    func getCourses() {
        interactor.getCourses()
    }
    
    func getUTMs() {
        interactor.getUTMs()
    }
    
    func getOccuptions() {
        interactor.getOccuptions()
    }
    
    func getTargets() {
        interactor.getTargets()
    }
    
    func getStatuses() {
        interactor.getStatuses()
    }
    
    func didGetClient(data: Data) {
        interactor.didGetClient(data: data)
    }
    
    func didGetWorker(data: Data) {
        interactor.didGetWorker(data: data)
    }
    
    func goBack() {
        router.pop()
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension AddPagePersonPresenter: AddPagePersonInteractorOutput {
    func didGetSuccess() {
        router.pop()
    }
    
    func didGetFail(message: String) {
        view.didGetFail(message: message)
    }
    
    func didGet(positions: [PositionModel]) {
        view.didGet(positions: positions)
    }
    
    func didGet(courses: [CourseModel]) {
        view.didGet(courses: courses)
    }
    
    func didGet(utms: [UTMModel]) {
        view.didGet(utms: utms)
    }
    
    func didGet(targets: [TargetModel]) {
        view.didGet(targets: targets)
    }
    
    func didGet(occupations: [OccupationModel]) {
        view.didGet(occupations: occupations)
    }
    
    func didGet(statuses: [StatusModel]) {
        view.didGet(statuses: statuses)
    }

}
