//
//  SecondRegistrationScreenSecondRegistrationScreenInteractor.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 05/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//


class SecondRegistrationScreenInteractor {
    weak var output: SecondRegistrationScreenInteractorOutput!
    
    private let userDefaultsService: UserDefaultsService
    
    required init(userDefaultsService: UserDefaultsService) {
        self.userDefaultsService = userDefaultsService
    }
    
    private func saveInStorage(email: String, number: String, city: String) {
        let c = city.lowercased() == "бишкек" ? "Bishkek" : "Osh"
        userDefaultsService.saveCreateUser(value: email, key: .CreateUserEmail)
        userDefaultsService.saveCreateUser(value: number, key: .CreateUserPhoneNo)
        userDefaultsService.saveCreateUser(value: c, key: .CreateUserCity)
    }
}


// MARK: - Interactor Input

extension SecondRegistrationScreenInteractor: SecondRegistrationScreenInteractorInput {
    
    func isDataValid(data: (String?, String?, String)) -> (Bool, Bool) {
        var isEmailOk = false
        var isNumberOk = false
        if let text = data.1, text.isTelephoneNumberOk() {
            isNumberOk = true
        }
        if let text = data.0, text.isEmailOk() {
            isEmailOk = true
        }
        if isEmailOk && isNumberOk {
            saveInStorage(email: data.0!, number: data.1!, city: data.2)
        }
        return (isNumberOk, isEmailOk)
    }
}
