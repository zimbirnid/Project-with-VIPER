//
//  PaymentPagePaymentPageViewInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 20/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol PaymentPageViewInput: class {

    /**
        @author zhakshylykov-f
        Setup initial state of the view
    */

    func setupInitialState()
    func didGetFail(message: String)
    func didGetSuccess()
    func didGetMethods(methods: [MethodModel])
}
