//
//  FilterPageFilterPagePresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 14/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

class FilterPagePresenter {
    weak var view: FilterPageViewInput!
    var interactor: FilterPageInteractorInput!
    var router: FilterPageRouterInput!
}


// MARK: - Module Input

extension FilterPagePresenter: FilterPageModuleInput {}


// MARK: - View Output

extension FilterPagePresenter: FilterPageViewOutput {
    func didGetData(courses: [Int]?, statuses: [Int]?, occupations: [Int]?, positions: [Int]?, utms: [Int]?) {
        router.didGetData(courses: courses, statuses: statuses, occupations: occupations, positions: positions, utms: utms)
        view.didGetSuccess()
    }
    func getData() {
        interactor.getData()
    }
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension FilterPagePresenter: FilterPageInteractorOutput {
    func didGetFail(message: String) {
        view.didGetFail(message: message)
    }
    
    func didGetSuccess() {
        
    }
    
    func didGet(statuses: [StatusModel]) {
        view.didGet(statuses: statuses)
    }
    
    func didGet(courses: [CourseModel]) {
        view.didGet(courses: courses)
    }
    
    func didGet(occupations: [OccupationModel]) {
        view.didGet(occupations: occupations)
    }
    
    func didGet(positions: [PositionModel]) {
        view.didGet(positions: positions)
    }
    
    func didGet(utms: [UTMModel]) {
        view.didGet(utms: utms)
    }
}
