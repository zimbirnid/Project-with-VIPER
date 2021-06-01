//
//  ForgotPasswordScreenForgotPasswordScreenPresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 10/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

class ForgotPasswordScreenPresenter {
    weak var view: ForgotPasswordScreenViewInput!
    var interactor: ForgotPasswordScreenInteractorInput!
    var router: ForgotPasswordScreenRouterInput!
}


// MARK: - Module Input

extension ForgotPasswordScreenPresenter: ForgotPasswordScreenModuleInput {}


// MARK: - View Output

extension ForgotPasswordScreenPresenter: ForgotPasswordScreenViewOutput {
    func accountHaveTapped() {
        router.accountHaveTapped()
    }
    
    func nextPage() {
        router.openNextModule()
    }
    
    func buttonTapped() {
        let email = view.getEmail()
        let isOk = interactor.isEmailOk(email: email)
        if isOk {
            interactor.checkInService(email: email) 
        } else {
            view.invalidEmail()
        }
    }
    
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension ForgotPasswordScreenPresenter: ForgotPasswordScreenInteractorOutput {
    func showAlert(message: String) {
        view.showAlert(message: message)
    }
    
    func didGetFail() {
        view.invalidEmail()
    }
}
