//
//  MainCardDetailMainCardDetailPresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 23/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

class MainCardDetailPresenter {
    weak var view: MainCardDetailViewInput!
    var interactor: MainCardDetailInteractorInput!
    var router: MainCardDetailRouterInput!
}


// MARK: - Module Input

extension MainCardDetailPresenter: MainCardDetailModuleInput {}


// MARK: - View Output

extension MainCardDetailPresenter: MainCardDetailViewOutput {
    func addPayment(client: ClientModel) {
        router.addPayment(client: client)
    }
    
    func goBack() {
        router.goToPrev()
    }
    
    func getDropDownData() {
        interactor.getDropDownData()
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension MainCardDetailPresenter: MainCardDetailInteractorOutput {
    func didGetSuccess() {
        view.didGetSuccess()
        router.goToPrev()
        
    }
    
    func pop() {
        router.goToPrev()
    }
    func change(id: Int, data: Data) {
        interactor.change(id: id, data: data)
    }
    func didGet(occupations: [OccupationModel]) {
        view.didGet(occupations: occupations)
    }
    
    func didGet(targets: [TargetModel]) {
        view.didGet(targets: targets)
    }
    
    func didGet(statuses: [StatusModel]) {
        view.didGet(statuses: statuses)
    }
    
    func didGet(courses: [CourseModel]) {
        view.didGet(courses: courses)
    }
    
    func didGet(sources: [UTMModel]) {
        view.didGet(sources: sources)
    }
    
    func didGetFail(message: String) {
        view.didGetFail(message: message)
    }
}
