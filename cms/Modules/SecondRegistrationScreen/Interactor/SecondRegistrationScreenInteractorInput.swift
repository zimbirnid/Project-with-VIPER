//
//  SecondRegistrationScreenSecondRegistrationScreenInteractorInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 05/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol SecondRegistrationScreenInteractorInput {
    func isDataValid(data: (String?, String?, String)) -> (Bool, Bool)
}
