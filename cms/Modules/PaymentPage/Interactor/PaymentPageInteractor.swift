//
//  PaymentPagePaymentPageInteractor.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 20/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

class PaymentPageInteractor {
    weak var output: PaymentPageInteractorOutput!
    
    private let networkService: NetworkService
    private let userDefaultsService: UserDefaultsService
    
    required init(ns: NetworkService, uds: UserDefaultsService) {
        networkService = ns
        userDefaultsService = uds
    }
}


// MARK: - Interactor Input

extension PaymentPageInteractor: PaymentPageInteractorInput {
    
    func didGet(model: PaymentsPostModel, client: ClientModel) {
        guard let data = model.toJSONData() else {return}
        var request =
            userDefaultsService.isCityBishkek()
            ? BishkekClientController.addPayment(client_id: "\(client.clientID!)", body: data).createURLRequest()
            : OshClientController.addPayment(client_id: "\(client.clientID!)", body: data).createURLRequest()
        
        if
            let p = client.payments?.filter({$0.month == model.month && $0.course?.id == client.course?.id}).first {
            var done = false
            if p.price! + model.price! >= (p.course?.price)! {
                done = true
            }
            guard
                let newData = PaymentsPostModel(
                    done: done,
                    methodID: model.methodID,
                    month: model.month,
                    price: (model.price ?? 0) + (p.price ?? 0)).toJSONData()
            else {return}
            request =
                userDefaultsService.isCityBishkek()
                ? BishkekClientController.editPayment(
                    client_id: "\(client.clientID!)",
                    payment_id: "\(p.id!)",
                    body: newData
                ).createURLRequest()
                : OshClientController.editPayment(
                    client_id: "\(client.clientID!)",
                    payment_id: "\(p.id!)",
                    body: newData
                ).createURLRequest()
        }
        
        networkService.sendRequest(
            urlRequest: request,
            successModel: ClientModel.self
        ) { [weak self] result in
            guard let self = self, let output = self.output else {return}
            switch result {
            case let .success(success):
                DispatchQueue.main.async {
                    output.didGetSuccess(sum: model.price ?? 0)
                }
                debugPrint(#function, success.clientID!)
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
            case let .failure(message):
                DispatchQueue.main.async {
                    output.didGetFail(message: message)
                }
                debugPrint(#function, message)
            }
        }
    }
    
    func getMethods() {
        networkService.sendRequest(
            urlRequest: PaymentMethodController.getAllMethods.createURLRequest(),
            successModel: [MethodModel].self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case let .success(model):
                DispatchQueue.main.async {
                    output.didGetMethods(methods: model)
                }
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
            case let .failure(message):
                DispatchQueue.main.async {
                    output.didGetFail(message: message)
                }
                debugPrint(#function, message)
            }
        }
    }
}
