//
//  RestorePasswordScreenRestorePasswordScreenInteractor.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 10/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

class RestorePasswordScreenInteractor {
    weak var output: RestorePasswordScreenInteractorOutput!
}


// MARK: - Interactor Input

extension RestorePasswordScreenInteractor: RestorePasswordScreenInteractorInput {
    func isValid(data: (String?, String?, String?)) -> (Bool, Bool, Bool) {
        var isEmailOk = false
        var isPasswordOk = false
        var isAgainPasswordOk = false
        
        if let email = data.0, email.contains("@"), email.contains(".") {
            isEmailOk = true
        }
        if let password = data.1, password.count > 7 {
            isPasswordOk = true
            if let againPassword = data.2, againPassword == password {
                isAgainPasswordOk = true
            }
        }
        return (isEmailOk, isPasswordOk, isAgainPasswordOk)
    }
}
