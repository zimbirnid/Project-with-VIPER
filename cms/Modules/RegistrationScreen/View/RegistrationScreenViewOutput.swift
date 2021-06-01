//
//  RegistrationScreenRegistrationScreenViewOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 04/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation
@objc protocol RegistrationScreenViewOutput {

    /**
        @author zhakshylykov-f
        Notify presenter that view is ready
    */

    func viewIsReady()
    @objc func buttonTapped()
    @objc func nextPage()
}
