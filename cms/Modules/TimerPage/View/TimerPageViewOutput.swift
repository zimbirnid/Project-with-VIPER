//
//  TimerPageTimerPageViewOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 07/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

protocol TimerPageViewOutput {

    /**
        @author zhakshylykov-f
        Notify presenter that view is ready
    */

    func viewIsReady()
    func save(client: ClientModel)
    func cancelTapped()
}
