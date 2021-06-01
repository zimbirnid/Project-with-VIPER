//
//  ClientsPageClientsPagePresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 26/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

class ClientsPagePresenter {
    weak var view: ClientsPageViewInput!
    var interactor: ClientsPageInteractorInput!
    var router: ClientsPageRouterInput!
}


// MARK: - Module Input

extension ClientsPagePresenter: ClientsPageModuleInput {}


// MARK: - View Output

extension ClientsPagePresenter: ClientsPageViewOutput {
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
    
    func getClients(update: Bool) {
        interactor.getClients(update: update)
    }
    
    func getUsername() {
        interactor.getUsername() 
    }
   
    func cellTapped(with: ClientModel) {
        router.cellTapped(with: with)
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension ClientsPagePresenter: ClientsPageInteractorOutput {
    func didGet(clients: [ClientModel], updateData: Bool) {
        view.didGet(clients: clients, updateData: updateData)
    }
    
    func didGet(name: String) {
        view.didGet(name: name)
    }
    
    func didGetFail(message: String) {
        view.didGetFail(message: message)
    }
}
