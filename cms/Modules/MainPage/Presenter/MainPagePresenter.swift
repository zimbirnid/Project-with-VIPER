//
//  MainPageMainPagePresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 15/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import UIKit

class MainPagePresenter {
    weak var view: MainPageViewInput!
    var interactor: MainPageInteractorInput!
    var router: MainPageRouterInput!
}


// MARK: - Module Input

extension MainPagePresenter: MainPageModuleInput {}


// MARK: - View Output

extension MainPagePresenter: MainPageViewOutput {
    func cellTapped(with: ClientModel) {
        router.cellTapped(with: with)
    }
    
    func timerPressed(client: ClientModel) {
        router.timerPressed(client: client)
    }
    
    func logoutTapped() {
        router.logoutTapped()
    }
    
    func getClients(byStatus: String) {
        interactor.getClients(byStatus: byStatus)
    }
    
    func getStatuses() {
        interactor.getStatuses()
    }
    
    func getUsername() {
        interactor.getUsername()
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
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
}


// MARK: - Interactor Output

extension MainPagePresenter: MainPageInteractorOutput {
    func didGetFiltered(clients: [ClientModel], update: Bool) {
        view.didGetFiltered(clients: clients, update: update)
    }
    
    func didGet(userName: String) {
        view.didGet(userName: userName)
    }
    
    func didGetNotifications(models: [ClientModel]) {
        view.didGetNotifications(models: models)
    }
    
    func didGetClientsModels(models: [ClientModel]) {
        view.didGetClientsModels(models: models)
    }
    
    func didGetStatusModel(models: [StatusModel]) {
        view.didGetStatusModel(models: models)
    }
    
    func didGetFail(message: String) {
        view.didGetFail(message: message)
    }
}
