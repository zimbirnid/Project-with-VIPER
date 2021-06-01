//
//  RegistrationScreenRegistrationScreenViewInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 04/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol RegistrationScreenViewInput: class {

    /**
        @author zhakshylykov-f
        Setup initial state of the view
    */

    func setupInitialState()
    func getData() -> (String?, String?, String?, String)
    func noData(In: Int)
}
