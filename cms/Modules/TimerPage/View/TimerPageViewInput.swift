//
//  TimerPageTimerPageViewInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 07/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol TimerPageViewInput: class {

    /**
        @author zhakshylykov-f
        Setup initial state of the view
    */

    func setupInitialState()
    func didGetSuccess()
    func didGetFail(message: String)
}
