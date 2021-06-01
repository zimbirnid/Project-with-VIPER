//
//  RestorePasswordScreenRestorePasswordScreenViewOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 10/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

@objc protocol RestorePasswordScreenViewOutput {

    /**
        @author zhakshylykov-f
        Notify presenter that view is ready
    */

    func viewIsReady()
    @objc func buttonTapped()
    @objc func haveAccountTapped()
}
