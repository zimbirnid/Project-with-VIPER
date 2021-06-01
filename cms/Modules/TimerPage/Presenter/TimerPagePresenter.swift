//
//  TimerPageTimerPagePresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 07/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

class TimerPagePresenter {
    weak var view: TimerPageViewInput!
    var interactor: TimerPageInteractorInput!
    var router: TimerPageRouterInput!
}


// MARK: - Module Input

extension TimerPagePresenter: TimerPageModuleInput {}


// MARK: - View Output

extension TimerPagePresenter: TimerPageViewOutput {
    func save(client: ClientModel) {
        interactor.save(client: client)
    }

    func cancelTapped() {
        router.dismiss()
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension TimerPagePresenter: TimerPageInteractorOutput {
    func didGetFail(message: String) {
        view.didGetFail(message: message)
    }
    
    func didGetSuccess() {
        view.didGetSuccess()
        router.dismiss()
    }
}
