//
//  RegistrationScreenRegistrationScreenPresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 04/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

class RegistrationScreenPresenter {
    weak var view: RegistrationScreenViewInput!
    var interactor: RegistrationScreenInteractorInput!
    var router: RegistrationScreenRouterInput!
}


// MARK: - Module Input

extension RegistrationScreenPresenter: RegistrationScreenModuleInput {}


// MARK: - View Output

extension RegistrationScreenPresenter: RegistrationScreenViewOutput {
    
    func nextPage() {
        router.openNextModule()
    }
   
    func buttonTapped() {
        let data = view.getData()
        let isValid = interactor.isDataValid(data: data)
        if !isValid.0 {
            view.noData(In: 0)
        } else if !isValid.1 {
            view.noData(In: 1)
        } else if !isValid.2 {
            view.noData(In: 2)
        } else if !isValid.3 {
            view.noData(In: 3)
        } else {
            router.openNextModule()
        }
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension RegistrationScreenPresenter: RegistrationScreenInteractorOutput {

}
