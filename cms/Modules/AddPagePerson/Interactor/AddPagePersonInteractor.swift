//
//  AddPagePersonAddPagePersonInteractor.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 03/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

class AddPagePersonInteractor {
    weak var output: AddPagePersonInteractorOutput!
    
    private let networkService: NetworkService
    private let userDefaultsService: UserDefaultsService
    private var alreadyAuthAgain = false
    
    required init(ns: NetworkService, uds: UserDefaultsService) {
        networkService = ns
        userDefaultsService = uds
    }
    private func authorizeAgain() {
        let auth = userDefaultsService.getAuth()
        guard let data = [
            "email": auth.0,
            "password": auth.1
        ].toData() else {return}
        userDefaultsService.save(token: nil)
        networkService.sendRequest(
            urlRequest: AuthController.getToken(body: data).createURLRequest(),
            successModel: TokenModel.self
        ) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case let .success(model):
                self.userDefaultsService.save(token: model.token)
                self.getCourses()
                self.getTargets()
                self.getStatuses()
                self.getPositions()
                self.getOccuptions()
                self.getUTMs()
            case let .badRequest(model):
                DispatchQueue.main.async {
                    AppUtility.goToAuthentificationPage()
                }
                debugPrint(#function, model)
            case let .unauthorized(message):
                DispatchQueue.main.async {
                    AppUtility.goToAuthentificationPage()
                }
                debugPrint(#function, message)
            case let .forbidden(model, message):
                DispatchQueue.main.async {
                    AppUtility.goToAuthentificationPage()
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .notFound(model):
                DispatchQueue.main.async {
                    AppUtility.goToAuthentificationPage()
                }
                debugPrint(#function, model)
            case let .methodNotAllowed(model, message):
                DispatchQueue.main.async {
                    AppUtility.goToAuthentificationPage()
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .gone(model):
                DispatchQueue.main.async {
                    AppUtility.goToAuthentificationPage()
                }
                debugPrint(#function, model)
            case let .unsupportedMediaType(model, message):
                DispatchQueue.main.async {
                    AppUtility.goToAuthentificationPage()
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .internalServerError(model):
                DispatchQueue.main.async {
                    AppUtility.goToAuthentificationPage()
                }
                debugPrint(#function, model)
            case let .notImplemented(model):
                DispatchQueue.main.async {
                    AppUtility.goToAuthentificationPage()
                }
                debugPrint(#function, model)
            case let .serviceUnavailable(model, message):
                DispatchQueue.main.async {
                    AppUtility.goToAuthentificationPage()
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .failure(message):
                DispatchQueue.main.async {
                    AppUtility.goToAuthentificationPage()
                }
                debugPrint(#function, message)
            }
        }
    }
}


// MARK: - Interactor Input

extension AddPagePersonInteractor: AddPagePersonInteractorInput {
    
    func getCourses() {
        let request =
            userDefaultsService.isCityBishkek()
            ? BishkekCourseController.getAll.createURLRequest()
            : OshCourseController.getAll.createURLRequest()
        
        networkService.sendRequest(
            urlRequest: request,
            successModel: [CourseModel].self
        ) {
            [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                debugPrint(#function, model.count)
                DispatchQueue.main.async {
                    output.didGet(courses: model)
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
            case .failure(let error):
                DispatchQueue.main.async {
                    output.didGetFail(message: error)
                }
                debugPrint(#function, error)
            }
        }
    }
    
    func getUTMs() {
        networkService.sendRequest(
            urlRequest: UTMController.getUTMs.createURLRequest(),
            successModel: [UTMModel].self
        ) {
            [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    output.didGet(utms: model)
                }
                debugPrint(#function, model.count)
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
    
    func getPositions() {
        networkService.sendRequest(
            urlRequest: PositionController.getAllPositions.createURLRequest(),
            successModel: [PositionModel].self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    output.didGet(positions: model)
                }
                debugPrint(#function, model.count)
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
    
    func getOccuptions() {
        networkService.sendRequest(
            urlRequest: OccupationController.getOccupations.createURLRequest(),
            successModel: [OccupationModel].self
        ) {
            [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    output.didGet(occupations: model)
                }
                debugPrint(#function, model.count)
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
    
    func getTargets() {
        networkService.sendRequest(
            urlRequest: TargetContoller.getAllTargets.createURLRequest(),
            successModel: [TargetModel].self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    output.didGet(targets: model)
                }
                debugPrint(#function, model.count)
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
    
    func getStatuses() {
        networkService.sendRequest(
            urlRequest: StatusController.getStatuses.createURLRequest(),
            successModel: [StatusModel].self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    output.didGet(statuses: model)
                }
                debugPrint(#function, model.count)
            case let .badRequest(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message?.replacingOccurrences(of: "  ", with: " ") ?? "")
                }
                debugPrint(#function, model)
            case let .unauthorized(message):
                if self.alreadyAuthAgain {
                    DispatchQueue.main.async {
                        output.didGetFail(message: message)
                    }
                } else {
                    self.authorizeAgain()
                    self.alreadyAuthAgain = true
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
    
    
    func didGetClient(data: Data) {
        let request =
            userDefaultsService.isCityBishkek()
            ? BishkekClientController.addClient(body: data).createURLRequest()
            : OshClientController.addClient(body: data).createURLRequest()
        
        networkService.sendRequest(
            urlRequest: request,
            successModel: ClientModel.self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    output.didGetSuccess()
                }
                debugPrint(#function, model.clientID)
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
    
    func didGetWorker(data: Data) {
        let request =
            userDefaultsService.isCityBishkek()
            ? BishkekTeacherController.addNewTeacher(body: data).createURLRequest()
            : OshTeacherController.addNewTeacher(body: data).createURLRequest()
        
        networkService.sendRequest(
            urlRequest: request,
            successModel: TeacherModel.self
        ) {
            [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    output.didGetSuccess()
                }
                debugPrint(#function, model.workerID)
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
