//
//  ForgotPasswordScreenForgotPasswordScreenInteractorInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 10/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol ForgotPasswordScreenInteractorInput {
    func isEmailOk(email: String?) -> Bool
    func checkInService(email: String?)
}
