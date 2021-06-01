//
//  AuthenticationOneAuthenticationOneViewOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 02/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol AuthenticationOneViewOutput {

    /**
        @author zhakshylykov-f
        Notify presenter that view is ready
    */

    func viewIsReady()
    func didTapEnter()
    func didTapForget()
    func didTapRegisterButton()
    func checkData(text: String?, textFieldNumber: Int)
}
