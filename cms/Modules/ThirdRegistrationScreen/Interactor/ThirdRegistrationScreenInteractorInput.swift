//
//  ThirdRegistrationScreenThirdRegistrationScreenInteractorInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 09/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol ThirdRegistrationScreenInteractorInput {
    func isDataValid(data: (String?, String?)) -> (Bool, Bool)
}
