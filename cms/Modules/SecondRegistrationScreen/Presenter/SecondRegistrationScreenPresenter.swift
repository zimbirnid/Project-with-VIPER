//
//  SecondRegistrationScreenSecondRegistrationScreenPresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 05/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

class SecondRegistrationScreenPresenter {
    weak var view: SecondRegistrationScreenViewInput!
    var interactor: SecondRegistrationScreenInteractorInput!
    var router: SecondRegistrationScreenRouterInput!
}


// MARK: - Module Input

extension SecondRegistrationScreenPresenter: SecondRegistrationScreenModuleInput {}


// MARK: - View Output

extension SecondRegistrationScreenPresenter: SecondRegistrationScreenViewOutput {
    
    func goBack() {
        router.goBack()
    }
    
    func buttonTapped() {
        let data = view.getData()
        let isValid = interactor.isDataValid(data: data)
        if !isValid.0 {
            view.noData(In: 0)
        } else if !isValid.1 {
            view.noData(In: 1)
        } else {
            router.openNextModule()
        }
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension SecondRegistrationScreenPresenter: SecondRegistrationScreenInteractorOutput {

}
