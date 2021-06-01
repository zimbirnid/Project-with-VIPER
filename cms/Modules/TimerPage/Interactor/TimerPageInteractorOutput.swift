//
//  TimerPageTimerPageInteractorOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 07/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol TimerPageInteractorOutput: class {
    func didGetSuccess()
    func didGetFail(message: String)
}
