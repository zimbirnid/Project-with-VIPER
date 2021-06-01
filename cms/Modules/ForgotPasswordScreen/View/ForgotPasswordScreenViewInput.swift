//
//  ForgotPasswordScreenForgotPasswordScreenViewInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 10/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol ForgotPasswordScreenViewInput: class {

    /**
        @author zhakshylykov-f
        Setup initial state of the view
    */

    func setupInitialState()
    func getEmail() -> String?
    func showAlert(message: String)
    func invalidEmail()
}
