//
//  AuthenticationOneAuthenticationOnePresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 02/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

class AuthenticationOnePresenter {
    weak var view: AuthenticationOneViewInput!
    var interactor: AuthenticationOneInteractorInput!
    var router: AuthenticationOneRouterInput!
}


// MARK: - Module Input

extension AuthenticationOnePresenter: AuthenticationOneModuleInput {}


// MARK: - View Output

extension AuthenticationOnePresenter: AuthenticationOneViewOutput {
    
    func checkData(text: String?, textFieldNumber: Int) {
        let isOk = interactor.checkData(text: text, textFieldNumber: textFieldNumber)
        view.dataChecked(isOk: isOk, textFieldNumber: textFieldNumber)
    }
    
    func didTapEnter() {
        let data = view.getData()
        interactor.checkDataValidness(data: data)
    }
    
    func didTapForget() {
        router.openForgetPage()
    }
    
    func didTapRegisterButton() {
        router.openRegisterPage() 
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension AuthenticationOnePresenter: AuthenticationOneInteractorOutput {
    func didGetResponse(response: Bool) {
        if response {
            view.validData()
            router.openNextModule()
        } else {
            view.invalidData()
        }
    }
}
