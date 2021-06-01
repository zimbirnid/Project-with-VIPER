//
//  PaymentPagePaymentPageInteractorInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 20/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol PaymentPageInteractorInput {
    func didGet(model: PaymentsPostModel, client: ClientModel)
    func getMethods()
}
