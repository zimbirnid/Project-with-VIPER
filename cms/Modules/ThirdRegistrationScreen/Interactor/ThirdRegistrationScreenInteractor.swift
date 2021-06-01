//
//  ThirdRegistrationScreenThirdRegistrationScreenInteractor.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 09/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

class ThirdRegistrationScreenInteractor {
    weak var output: ThirdRegistrationScreenInteractorOutput!
    
    private let networkService: NetworkService
    private let userDefaultsService: UserDefaultsService
    
    required init(ns: NetworkService, uds: UserDefaultsService) {
        networkService = ns
        userDefaultsService = uds
    }
    
    private func saveInStorage(password: String) {
        guard let object = CreateUserModel(
            city: userDefaultsService.getCreatedUserValue(byKey: .CreateUserCity),
            email: userDefaultsService.getCreatedUserValue(byKey: .CreateUserEmail),
            name: userDefaultsService.getCreatedUserValue(byKey: .CreateUserName),
            password: password,
            patronymic: userDefaultsService.getCreatedUserValue(byKey: .CreateUserPatronymic),
            phoneNo: userDefaultsService.getCreatedUserValue(byKey: .CreateUserPhoneNo),
            position: userDefaultsService.getCreatedUserValue(byKey: .CreateUserPosition),
            surname: userDefaultsService.getCreatedUserValue(byKey: .CreateUserSurname)
        ).toJSONData() else {return}
        
        networkService.sendRequest(
            urlRequest: AuthController.createUser(body: object).createURLRequest(),
            successModel: MessageModel.self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    output.didGetSuccess()
                }
                debugPrint(#function, model)
            case let .badRequest(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message?.replacingOccurrences(of: "  ", with: " ") ?? "")
                }
                debugPrint(#function, model)
            case let .unauthorized(message):
                DispatchQueue.main.async {
                    output.didGetFail(message: message)
                }
                debugPrint(#function, message)
            case let .forbidden(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message?.replacingOccurrences(of: "  ", with: " ") ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .notFound(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message?.replacingOccurrences(of: "  ", with: " ") ?? "")
                }
                debugPrint(#function, model)
            case let .methodNotAllowed(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message?.replacingOccurrences(of: "  ", with: " ") ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .gone(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message?.replacingOccurrences(of: "  ", with: " ") ?? "")
                }
                debugPrint(#function, model)
            case let .unsupportedMediaType(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message?.replacingOccurrences(of: "  ", with: " ") ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .internalServerError(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message?.replacingOccurrences(of: "  ", with: " ") ?? "")
                }
                debugPrint(#function, model)
            case let .notImplemented(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message?.replacingOccurrences(of: "  ", with: " ") ?? "")
                }
                debugPrint(#function, model)
            case let .serviceUnavailable(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message?.replacingOccurrences(of: "  ", with: " ") ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case .failure(let error):
                DispatchQueue.main.async {
                    output.didGetFail(message: error)
                }
                debugPrint(#function, error)
            }
        }
    }
}


// MARK: - Interactor Input

extension ThirdRegistrationScreenInteractor: ThirdRegistrationScreenInteractorInput {
    func isDataValid(data: (String?, String?)) -> (Bool, Bool) {
        var isFirstOk = false
        var isSecondOk = false
        if let first = data.0, !first.isEmpty, first.count > 7 {
            isFirstOk = true
            if let second = data.1, !second.isEmpty, second.count > 7, first == second {
                isSecondOk = true
            }
        }
        if isFirstOk && isSecondOk {
            saveInStorage(password: data.0!)
        }
        return (isFirstOk, isSecondOk)
    }
}
