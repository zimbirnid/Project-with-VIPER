//
//  ThirdRegistrationScreenThirdRegistrationScreenViewInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 09/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol ThirdRegistrationScreenViewInput: class {

    /**
        @author zhakshylykov-f
        Setup initial state of the view
    */

    func setupInitialState()
    func getData() -> (String?, String?)
    func noData(In: Int)
    func didGetSuccess()
    func didGetFail(message: String)
}
