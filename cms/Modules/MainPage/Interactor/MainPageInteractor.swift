//
//  MainPageMainPageInteractor.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 15/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

class MainPageInteractor {
    weak var output: MainPageInteractorOutput!
    
    private let networkService: NetworkService
    private let userDefaultsService: UserDefaultsService
    
    private var currentPage = 0
    private var previousPage = -1
    private var maximumPage = 111
    private var isGettingFromServer = false
    private var alreadyAuthAgain = false
    
    private var courses = [Int]()
    private var statuses = [Int]()
    private var occupations = [Int]()
    private var positions = [Int]()
    private var utms = [Int]()
    
    required init(ns: NetworkService, uds: UserDefaultsService) {
        networkService = ns
        userDefaultsService = uds
    }
    
    private func updateData() {
        currentPage = 0
        previousPage = -1
        maximumPage = 11111
        isGettingFromServer = false
        alreadyAuthAgain = false
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
                self.fetchStatuses()
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
    
    private func fetchClientsWithExpiredTimer() {
        let request =
            userDefaultsService.isCityBishkek()
            ? BishkekClientController.getClientsWithExpiredTimer.createURLRequest()
            : OshClientController.getClientsWithExpiredTimer.createURLRequest()
        
        networkService.sendRequest(
            urlRequest: request,
            successModel: [ClientModel].self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case let .success(model):
                DispatchQueue.main.async {
                    output.didGetNotifications(models: model)
                }
            case let .badRequest(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .unauthorized(message):
                DispatchQueue.main.async {
                    output.didGetFail(message: message)
                }
                debugPrint(#function, message)
            case let .forbidden(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .notFound(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .methodNotAllowed(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .gone(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .unsupportedMediaType(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .internalServerError(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .notImplemented(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .serviceUnavailable(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
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
    
    private func fetchStatuses() {
        networkService.sendRequest(
            urlRequest: StatusController.getStatusesDoska.createURLRequest(),
            successModel: [StatusModel].self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                let data = model.filter({$0.name?.lowercased() == "запись на курс" || $0.doska!})
                DispatchQueue.main.async {
                    output.didGetStatusModel(models: data)
                }
                debugPrint(#function, model.count)
            case let .badRequest(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
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
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .notFound(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .methodNotAllowed(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .gone(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .unsupportedMediaType(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .internalServerError(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .notImplemented(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .serviceUnavailable(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
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
    
    private func fetchClients(byStatus: String) {
        let request =
            userDefaultsService.isCityBishkek()
            ? BishkekClientController.getAllByStatus(status_id: byStatus).createURLRequest()
            : OshClientController.getAllByStatus(status_id: byStatus).createURLRequest()
        
        networkService.sendRequest(
            urlRequest: request,
            successModel: [ClientModel].self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                let data = model.filter(
                    { (m) -> Bool in
                        m.status?.name?.lowercased() != "отложено" &&
                        m.status?.name?.lowercased() != "окончил курс" &&
                        m.status?.name?.lowercased() != "не окончил курс" &&
                        m.status?.name?.lowercased() != "записался на курс"
                    }
                )
                DispatchQueue.main.async {
                    output.didGetClientsModels(models: data)
                }
                debugPrint(#function, data.count)
            case let .badRequest(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .unauthorized(message):
                DispatchQueue.main.async {
                    output.didGetFail(message: message)
                }
                debugPrint(#function, message)
            case let .forbidden(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .notFound(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .methodNotAllowed(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .gone(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .unsupportedMediaType(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .internalServerError(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .notImplemented(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .serviceUnavailable(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
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
    
    private func fetchUser() {
        let name = userDefaultsService.getByKey(key: .name)
        output.didGet(userName: name)
    }
}


// MARK: - Interactor Input

extension MainPageInteractor: MainPageInteractorInput {
    
    func getClients(byStatus: String) {
        fetchClients(byStatus: byStatus)
        fetchClientsWithExpiredTimer()
    }
    
    func getStatuses() {
        fetchStatuses()
    }

    func getUsername() {
        fetchUser()
    }
    
    func filterAgain() {
        filter(
            courses: courses,
            statuses: statuses,
            occupations: occupations,
            positions: positions,
            utms: utms,
            update: false
        )
    }
    
    func filter(
        courses: [Int]?,
        statuses: [Int]?,
        occupations: [Int]?,
        positions: [Int]?,
        utms: [Int]?,
        update: Bool
    ) {
        self.courses = courses ?? []
        self.statuses = statuses ?? []
        self.occupations = occupations ?? []
        self.positions = positions ?? []
        self.utms = utms ?? []
        if update {
            updateData()
        }
        if currentPage >= maximumPage {
            return
        }
        if currentPage <= previousPage {
            return
        }
        if isGettingFromServer {
            return
        }
        isGettingFromServer = true
        
        let request =
            userDefaultsService.isCityBishkek()
            ? BishkekClientController.filter(
                status_id: "\(statuses ?? [])",
                course_id: "\(courses ?? [])",
                occupation_id: "\(occupations ?? [])",
                utm_id: "\(utms ?? [])",
                page: "\(currentPage)",
                size: "20.",
                field: nil
            ).createURLRequest()
            : OshClientController.filter(
                status_id: "\(statuses ?? [])",
                course_id: "\(courses ?? [])",
                occupation_id: "\(occupations ?? [])",
                utm_id: "\(utms ?? [])",
                page: "\(currentPage)",
                size: "",
                field: nil
            ).createURLRequest()
        
        networkService.sendRequest(
            urlRequest: request,
            successModel: AllClientsModel.self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                guard let data = model.content else {return}
                DispatchQueue.main.async {
                    output.didGetFiltered(clients: data, update: update)
                }
                debugPrint(#function, data.count)
                self.isGettingFromServer = false
                self.currentPage += 1
                self.previousPage += 1
                self.maximumPage = model.totalPages ?? 111
            case let .badRequest(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .unauthorized(message):
                DispatchQueue.main.async {
                    output.didGetFail(message: message)
                }
                debugPrint(#function, message)
            case let .forbidden(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .notFound(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .methodNotAllowed(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .gone(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .unsupportedMediaType(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .internalServerError(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .notImplemented(model):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
                }
                debugPrint(#function, model)
            case let .serviceUnavailable(model, message):
                DispatchQueue.main.async {
                    output.didGetFail(message: model.message ?? "")
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
