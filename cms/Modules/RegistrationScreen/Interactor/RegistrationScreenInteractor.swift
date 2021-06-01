//
//  RegistrationScreenRegistrationScreenInteractor.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 04/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

class RegistrationScreenInteractor {
    weak var output: RegistrationScreenInteractorOutput!
    
    private let userDefaultsService: UserDefaultsService
    
    required init(userDefaultsService: UserDefaultsService) {
        self.userDefaultsService = userDefaultsService
    }
    
    private func checkData(data: (String?, String?, String?, String?)) -> (Bool, Bool, Bool, Bool)  {
        var isSurnameOk = false
        var isNameOk = false
        var isFatherNameOk = false
        var isOccupationOk = false
        if let text = data.0, !text.isEmpty, text.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil {
            isSurnameOk = true
        }
        if let text = data.1, !text.isEmpty {
            isNameOk = true
        }
        if let text = data.2, !text.isEmpty {
            isFatherNameOk = true
        }
        if let text = data.3, !text.isEmpty {
            isOccupationOk = true
        }
        if isSurnameOk, isNameOk, isOccupationOk, isFatherNameOk {
            saveInStorage(firstName: data.0!, lastName: data.1!, fatherName: data.2!, occupation: data.3!)
        }
        return (isSurnameOk, isNameOk, isFatherNameOk, isOccupationOk)
    }
    
    private func saveInStorage(firstName: String, lastName: String, fatherName: String, occupation: String) {
        let occup = occupation.lowercased() == "маркетолог" ? "marketing" : "management"
        userDefaultsService.saveCreateUser(value: occup, key: .CreateUserPosition)
        userDefaultsService.saveCreateUser(value: firstName, key: .CreateUserName)
        userDefaultsService.saveCreateUser(value: lastName, key: .CreateUserSurname)
        userDefaultsService.saveCreateUser(value: fatherName, key: .CreateUserPatronymic)
    }
}


// MARK: - Interactor Input

extension RegistrationScreenInteractor: RegistrationScreenInteractorInput {
    func isDataValid(data: (String?, String?, String?, String?)) -> (Bool, Bool, Bool, Bool) {
        return checkData(data: data)
    }
}
