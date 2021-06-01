//
//  PaymentPagePaymentPageInteractorOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 20/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol PaymentPageInteractorOutput: class {
    func didGetSuccess(sum: Int)
    func didGetFail(message: String)
    func didGetMethods(methods: [MethodModel])
}
