//
//  AuthenticationOneAuthenticationOneViewInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 02/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol AuthenticationOneViewInput: class {

    /**
        @author zhakshylykov-f
        Setup initial state of the view
    */

    func setupInitialState()
    func getData() -> (String?, String?)
    func invalidData()
    func validData()
    func dataChecked(isOk: Bool, textFieldNumber: Int)
}
