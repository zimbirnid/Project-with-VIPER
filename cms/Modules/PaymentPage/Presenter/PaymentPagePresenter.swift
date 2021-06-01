//
//  PaymentPagePaymentPagePresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 20/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

class PaymentPagePresenter {
    weak var view: PaymentPageViewInput!
    var interactor: PaymentPageInteractorInput!
    var router: PaymentPageRouterInput!
}


// MARK: - Module Input

extension PaymentPagePresenter: PaymentPageModuleInput {}


// MARK: - View Output

extension PaymentPagePresenter: PaymentPageViewOutput {
    func getMethods() {
        interactor.getMethods()
    }
    
    func didGet(model: PaymentsPostModel, client: ClientModel) {
        interactor.didGet(model: model, client: client)
    }
    
    func dismiss() {
        router.dismiss()
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension PaymentPagePresenter: PaymentPageInteractorOutput {
    func didGetMethods(methods: [MethodModel]) {
        view.didGetMethods(methods: methods)
    }
    
    func didGetSuccess(sum: Int) {
        router.dismiss(sum: sum)
    }
    
    func didGetFail(message: String) {
        view.didGetFail(message: message)
    }
}
