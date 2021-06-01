//
//  ThirdRegistrationScreenInteractorOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 09/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol ThirdRegistrationScreenInteractorOutput: class {
    func didGetFail(message: String)
    func didGetSuccess()
}
