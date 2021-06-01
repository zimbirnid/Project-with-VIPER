//
//  AuthenticationOneAuthenticationOneInteractorInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 02/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol AuthenticationOneInteractorInput {
    func checkDataValidness(data: (String?, String?))
    func checkData(text: String?, textFieldNumber: Int) -> Bool
}
