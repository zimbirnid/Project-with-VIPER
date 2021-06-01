//
//  StudentsPageStudentsPagePresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 27/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

class StudentsPagePresenter {
    weak var view: StudentsPageViewInput!
    var interactor: StudentsPageInteractorInput!
    var router: StudentsPageRouterInput!
}


// MARK: - Module Input

extension StudentsPagePresenter: StudentsPageModuleInput {}


// MARK: - View Output

extension StudentsPagePresenter: StudentsPageViewOutput {
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
    
    func logoutTapped() {
        router.logoutTapped()
    }
    
    func cellTapped(with: ClientModel) {
        router.cellTapped(with: with)
    }
    
    func getUsername() {
        interactor.getUsername()
    }
   
    func getStudents(update: Bool) {
        interactor.getStudents(update: update)
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension StudentsPagePresenter: StudentsPageInteractorOutput {
    func showFilterPage() {
        router.showFilterPage()
    }
    
    func didGetUser(name: String) {
        view.didGetUser(name: name)
    }
    
    func didGet(model: [ClientModel], updateData: Bool) {
        view.didGet(model: model, updateData: updateData)
    }
    
    func didGetFail(message: String) {
        view.didGetFail(message: message)
    }
}
