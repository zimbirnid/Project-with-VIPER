//
//  WorkersPageWorkersPagePresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 26/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

class WorkersPagePresenter {
    weak var view: WorkersPageViewInput!
    var interactor: WorkersPageInteractorInput!
    var router: WorkersPageRouterInput!
}


// MARK: - Module Input

extension WorkersPagePresenter: WorkersPageModuleInput {}


// MARK: - View Output

extension WorkersPagePresenter: WorkersPageViewOutput {
    func filterAgain() {
        interactor.filterAgain()
    }
    
    func filter(
        courses: [Int]?,
        statuses: [Int]?,
        occupations: [Int]?,
        positions: [Int]?,
        utms: [Int]?,
        update: Bool
    ) {
        interactor.filter(
            courses: courses,
            statuses: statuses,
            occupations: occupations,
            positions: positions,
            utms: utms,
            update: update
        )
    }
    
    func showFilterPage() {
        router.showFilterPage()
    }
    
    func logoutTapped() {
        router.logoutTapped()
    }
    
    func cellTapped(with: TeacherModel) {
        router.cellTapped(with: with)
    }
    
    func getUsername() {
        interactor.getUsername()
    }
    
    func getWorkers(update: Bool) {
        interactor.getWorkers(update: update)
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension WorkersPagePresenter: WorkersPageInteractorOutput {
    func didGet(name: String) {
        view.didGet(name: name) 
    }
    
    func didGet(workers: [TeacherModel], updateData: Bool) {
        view.didGet(workers: workers, updateData: updateData) 
    }
    
    func didGetFail(message: String) {
        view.didGetFail(message: message)
    }
}
