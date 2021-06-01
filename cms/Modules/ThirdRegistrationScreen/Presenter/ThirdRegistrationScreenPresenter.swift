//
//  ThirdRegistrationScreenThirdRegistrationScreenPresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 09/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

class ThirdRegistrationScreenPresenter {
    weak var view: ThirdRegistrationScreenViewInput!
    var interactor: ThirdRegistrationScreenInteractorInput!
    var router: ThirdRegistrationScreenRouterInput!
}


// MARK: - Module Input

extension ThirdRegistrationScreenPresenter: ThirdRegistrationScreenModuleInput {}


// MARK: - View Output

extension ThirdRegistrationScreenPresenter: ThirdRegistrationScreenViewOutput {
    
    func backTapped() {
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
    
    func popToHead() {
        router.popToHead()
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension ThirdRegistrationScreenPresenter: ThirdRegistrationScreenInteractorOutput {
    func didGetFail(message: String) {
        view.didGetFail(message: message)
    }
    
    func didGetSuccess() {
        view.didGetSuccess()
    }
}
