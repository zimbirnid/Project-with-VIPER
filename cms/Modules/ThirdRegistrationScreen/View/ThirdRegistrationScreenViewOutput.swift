//
//  ThirdRegistrationScreenThirdRegistrationScreenViewOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 09/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

@objc protocol ThirdRegistrationScreenViewOutput {

    /**
        @author zhakshylykov-f
        Notify presenter that view is ready
    */

    func viewIsReady()
    @objc func backTapped()
    @objc func buttonTapped()
    func popToHead()
}
