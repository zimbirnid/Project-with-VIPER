//
//  StudentsPageStudentsPageInteractor.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 27/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

class StudentsPageInteractor {
    weak var output: StudentsPageInteractorOutput!
    
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
                self.getStudents(update: true)
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

extension StudentsPageInteractor: StudentsPageInteractorInput {
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
                size: "20",
                field: ""
            ).createURLRequest()
            : OshClientController.filter(
                status_id: "\(statuses ?? [])",
                course_id: "\(courses ?? [])",
                occupation_id: "\(occupations ?? [])",
                utm_id: "\(utms ?? [])",
                page: "",
                size: "",
                field: ""
            ).createURLRequest()
        
        networkService.sendRequest(
            urlRequest: request,
            successModel: AllClientsModel.self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                self.maximumPage = model.totalPages ?? 111
                guard let data = model.content else {return}
                DispatchQueue.main.async {
                    output.didGet(model: data, updateData: true)
                }
                self.isGettingFromServer = false
                self.currentPage += 1
                self.previousPage += 1
                self.maximumPage = model.totalPages ?? 111111
                debugPrint(#function, data.count)
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
    
    func getUsername() {
        output.didGetUser(name: userDefaultsService.getByKey(key: .name))
    }

    func getStudents(update: Bool) {
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
            ? BishkekClientController.getAll(page: currentPage, size: 20).createURLRequest()
            : OshClientController.getAll(page: currentPage, size: 20).createURLRequest()
        
        networkService.sendRequest(
            urlRequest: request,
            successModel: AllClientsModel.self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                self.maximumPage = model.totalPages ?? 11111
                guard let model = model.content else {return}
                let data = model.filter(
                    {
                        $0.status?.name?.lowercased() == "запись на курс"
                    }
                )
                DispatchQueue.main.async {
                    output.didGet(model: data, updateData: update)
                }
                self.isGettingFromServer = false
                self.currentPage += 1
                self.previousPage += 1
                debugPrint(#function, data.count)
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
}
