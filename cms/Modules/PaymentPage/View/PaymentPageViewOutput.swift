//
//  PaymentPagePaymentPageViewOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 20/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol PaymentPageViewOutput {

    /**
        @author zhakshylykov-f
        Notify presenter that view is ready
    */

    func viewIsReady()
    func didGet(model: PaymentsPostModel, client: ClientModel)
    func dismiss()
    func getMethods()
}
