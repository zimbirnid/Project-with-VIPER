//
//  TimerPageTimerPageInteractor.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 07/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

class TimerPageInteractor {
    weak var output: TimerPageInteractorOutput!
    
    private let networkService: NetworkService
    private let userDefaultsService: UserDefaultsService
    
    required init(ns: NetworkService, uds: UserDefaultsService) {
        networkService = ns
        userDefaultsService = uds
    }
}


// MARK: - Interactor Input

extension TimerPageInteractor: TimerPageInteractorInput {
    func save(client: ClientModel) {
        guard let data = ClientPostModel(
            course: client.course?.id,
            description: client.description,
            email: client.email,
            experience: client.experience,
            laptop: client.laptop,
            leavingReason: client.leavingReason?.id,
            name: client.name,
            occupation: client.occupation?.id,
            patronymic: client.patronymic,
            phoneNo: client.phoneNo,
            prepayment: client.prepayment,
            status: client.status?.id,
            surname: client.surname,
            target: client.target?.id,
            timer: client.timer,
            utm: client.utm?.id
        ).toJSONData() else {return}
        
        let request =
            userDefaultsService.isCityBishkek()
            ? BishkekClientController.updateClient(id: "\(client.clientID!)", body: data).createURLRequest()
            : OshClientController.updateClient(id: "\(client.clientID!)", body: data).createURLRequest()
        
        networkService.sendRequest(
            urlRequest: request,
            successModel: ClientModel.self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success:
                DispatchQueue.main.async {
                    output.didGetSuccess()
                }
                debugPrint(#function, "sussess")
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
