//
//  RegistrationScreenRegistrationScreenInteractorInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 04/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol RegistrationScreenInteractorInput {
    func isDataValid(data: (String?, String?, String?, String?)) -> (Bool, Bool, Bool, Bool) 
}
