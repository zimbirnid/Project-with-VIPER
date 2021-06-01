//
//  ForgotPasswordScreenForgotPasswordScreenInteractor.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 10/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

class ForgotPasswordScreenInteractor {
    weak var output: ForgotPasswordScreenInteractorOutput!

    private let networkService: NetworkService
    private let userDefaultsService: UserDefaultsService
    
    required init(ns: NetworkService, uds: UserDefaultsService) {
        networkService = ns
        userDefaultsService = uds
    }
}


// MARK: - Interactor Input

extension ForgotPasswordScreenInteractor: ForgotPasswordScreenInteractorInput {
    func checkInService(email: String?) {
        guard let email = email else {return}
        userDefaultsService.save(token: nil)
        networkService.sendRequest(
            urlRequest: AuthController.forgotPassword(email: email).createURLRequest(),
            successModel: MessageModel.self
        ) { [weak self] (answer) in
            guard let self = self, let output = self.output else {return}
            switch answer {
            case .success(let model):
                DispatchQueue.main.async {
                    output.showAlert(message: email)
                }
                debugPrint(#function, model)
            case let .badRequest(model):
                DispatchQueue.main.async {
                    output.didGetFail()
                }
                debugPrint(#function, model)
            case let .unauthorized(message):
                DispatchQueue.main.async {
                    output.didGetFail()
                }
                debugPrint(#function, message)
            case let .forbidden(model, message):
                DispatchQueue.main.async {
                    output.didGetFail()
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .notFound(model):
                DispatchQueue.main.async {
                    output.didGetFail()
                }
                debugPrint(#function, model)
            case let .methodNotAllowed(model, message):
                DispatchQueue.main.async {
                    output.didGetFail()
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .gone(model):
                DispatchQueue.main.async {
                    output.didGetFail()
                }
                debugPrint(#function, model)
            case let .unsupportedMediaType(model, message):
                DispatchQueue.main.async {
                    output.didGetFail()
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .internalServerError(model):
                DispatchQueue.main.async {
                    output.didGetFail()
                }
                debugPrint(#function, model)
            case let .notImplemented(model):
                DispatchQueue.main.async {
                    output.didGetFail()
                }
                debugPrint(#function, model)
            case let .serviceUnavailable(model, message):
                DispatchQueue.main.async {
                    output.didGetFail()
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case .failure(let error):
                DispatchQueue.main.async {
                    output.didGetFail()
                }
                debugPrint(#function, error)
            }
        }
    }
    
    func isEmailOk(email: String?) -> Bool {
        guard let email = email, email.isEmailOk() else { return false }
        return true
    }
}
