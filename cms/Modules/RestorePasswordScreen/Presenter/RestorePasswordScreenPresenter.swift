//
//  RestorePasswordScreenRestorePasswordScreenPresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 10/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

class RestorePasswordScreenPresenter {
    weak var view: RestorePasswordScreenViewInput!
    var interactor: RestorePasswordScreenInteractorInput!
    var router: RestorePasswordScreenRouterInput!
}


// MARK: - Module Input

extension RestorePasswordScreenPresenter: RestorePasswordScreenModuleInput {}


// MARK: - View Output

extension RestorePasswordScreenPresenter: RestorePasswordScreenViewOutput {
    func buttonTapped() {
        let data = view.getData()
        let isValid = interactor.isValid(data: data)
        if !isValid.0 {
            view.noData(In: 0)
        } else if !isValid.1 {
            view.noData(In: 1)
        } else if !isValid.2 {
            view.noData(In: 2)
        } else {
            
        }
    }
    
    func haveAccountTapped() {
        router.goBack()
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension RestorePasswordScreenPresenter: RestorePasswordScreenInteractorOutput {

}
