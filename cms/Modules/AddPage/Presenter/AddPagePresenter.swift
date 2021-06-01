//
//  AddPageAddPagePresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 27/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

class AddPagePresenter {
    weak var view: AddPageViewInput!
    var interactor: AddPageInteractorInput!
    var router: AddPageRouterInput!
}


// MARK: - Module Input

extension AddPagePresenter: AddPageModuleInput {}


// MARK: - View Output

extension AddPagePresenter: AddPageViewOutput {
    func openPage(at: Int) {
        router.openPage(at: at)
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension AddPagePresenter: AddPageInteractorOutput {
}
