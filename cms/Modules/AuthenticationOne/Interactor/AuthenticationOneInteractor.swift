//
//  AuthenticationOneAuthenticationOneInteractor.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 02/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

class AuthenticationOneInteractor {
    weak var output: AuthenticationOneInteractorOutput!
    
    private let userDefaultsService: UserDefaultsService
    private let networkService: NetworkService
    
    private var email = ""
    private var password = ""
    
    private var isHaveOccupations = false
    private var isHaveCourses = false
    private var isHaveUTMs = false
    private var isHaveStatuses = false
    private var isHavePositions = false
    
    private var occupations = [OccupationModel]()
    private var courses = [CourseModel]()
    private var utms = [UTMModel]()
    private var statuses = [StatusModel]()
    private var positions = [PositionModel]()
    
    private let backgroundColors = [
        Colors.FuckingColors.a.color,
        Colors.FuckingColors.b.color,
        Colors.FuckingColors.c.color,
        Colors.FuckingColors.d.color,
        Colors.FuckingColors.e.color,
        Colors.FuckingColors.f.color,
        Colors.FuckingColors.g.color,
        Colors.FuckingColors.h.color,
        Colors.FuckingColors.i.color,
        Colors.FuckingColors.j.color,
        Colors.FuckingColors.k.color,
        Colors.FuckingColors.l.color,
        Colors.FuckingColors.m.color,
        Colors.FuckingColors.n.color,
        Colors.FuckingColors.o.color,
        Colors.FuckingColors.p.color,
        Colors.FuckingColors.q.color,
        Colors.FuckingColors.r.color,
        Colors.FuckingColors.s.color,
        Colors.FuckingColors.t.color,
        Colors.FuckingColors.u.color,
        Colors.FuckingColors.v.color,
        Colors.FuckingColors.w.color,
        Colors.FuckingColors.x.color,
        Colors.FuckingColors.y.color,
        Colors.FuckingColors.z.color,
        Colors.FuckingColors.A.color,
        Colors.FuckingColors.B.color,
        Colors.FuckingColors.C.color,
        Colors.FuckingColors.D.color,
        Colors.FuckingColors.E.color,
        Colors.FuckingColors.F.color,
    ]
    private let textColors = [
        Colors.FuckingColors.aa.color,
        Colors.FuckingColors.bb.color,
        Colors.FuckingColors.cc.color,
        Colors.FuckingColors.dd.color,
        Colors.FuckingColors.ee.color,
        Colors.FuckingColors.ff.color,
        Colors.FuckingColors.gg.color,
        Colors.FuckingColors.hh.color,
        Colors.FuckingColors.ii.color,
        Colors.FuckingColors.jj.color,
        Colors.FuckingColors.kk.color,
        Colors.FuckingColors.ll.color,
        Colors.FuckingColors.mm.color,
        Colors.FuckingColors.nn.color,
        Colors.FuckingColors.oo.color,
        Colors.FuckingColors.pp.color,
        Colors.FuckingColors.qq.color,
        Colors.FuckingColors.rr.color,
        Colors.FuckingColors.ss.color,
        Colors.FuckingColors.tt.color,
        Colors.FuckingColors.uu.color,
        Colors.FuckingColors.vv.color,
        Colors.FuckingColors.ww.color,
        Colors.FuckingColors.xx.color,
        Colors.FuckingColors.yy.color,
        Colors.FuckingColors.zz.color,
        Colors.FuckingColors.AA.color,
        Colors.FuckingColors.BB.color,
        Colors.FuckingColors.CC.color,
        Colors.FuckingColors.DD.color,
        Colors.FuckingColors.EE.color,
        Colors.FuckingColors.FF.color,
    ]
    
    required init(userDefaults: UserDefaultsService, network: NetworkService) {
        userDefaultsService = userDefaults
        networkService = network
    }
    
    private func sendDataToServer(body: Data) {
        userDefaultsService.save(token: nil)
        networkService.sendRequest(
            urlRequest: AuthController.getToken(body: body).createURLRequest(),
            successModel: TokenModel.self
        ) { [weak self] result in
            guard let self = self, let output = self.output else {return}
            debugPrint(#function)
            switch result {
            case .success(let model):
                self.userDefaultsService.save(token: model.token)
                self.saveUserData()
            case let .badRequest(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .unauthorized(message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, message)
            case let .forbidden(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .notFound(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .methodNotAllowed(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .gone(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .unsupportedMediaType(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .internalServerError(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .notImplemented(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .serviceUnavailable(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case .failure(let error):
                debugPrint(#function, error)
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
            }
        }
    }
    
    private func saveUserData() {
        networkService.sendRequest(
            urlRequest: UserController.profile.createURLRequest(),
            successModel: UserModel.self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                self.userDefaultsService.saveAuth(email: self.email, password: self.password)
                self.userDefaultsService.saveUser(name: model.name)
                self.userDefaultsService.saveCity(isBishkek: model.city?.lowercased() == "bishkek" || model.city?.lowercased() == "бишкек")
                self.userDefaultsService.saveAuthority(isAdmid: model.role?.authority == "ROLE_ADMIN")
                self.getAll()
                debugPrint(#function, model.id)
            case let .badRequest(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .unauthorized(message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, message)
            case let .forbidden(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .notFound(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .methodNotAllowed(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .gone(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .unsupportedMediaType(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .internalServerError(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .notImplemented(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .serviceUnavailable(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case .failure(let error):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, error)
            }
        }
    }
}


// MARK: - Interactor Input

extension AuthenticationOneInteractor: AuthenticationOneInteractorInput {
    
    func checkData(text: String?, textFieldNumber: Int) -> Bool {
        var isOk = false
        switch textFieldNumber {
        case 0:
            guard let email = text else {return false}
            isOk = email.isEmailOk()
        case 1:
            guard let password = text else {return false}
            isOk = password.isPasswordOk()
        default:
            break
        }
        return isOk
    }
    
    func checkDataValidness(data: (String?, String?)) {
        guard
            let email = data.0,
            email.isEmailOk(),
            let password = data.1,
            password.isPasswordOk()
        else {return}
        let data: [String: Any] = [
            "email": email,
            "password": password
        ]
        guard let body = data.toData() else {return}
        self.email = email
        self.password = password
        sendDataToServer(body: body)
    }
}

extension AuthenticationOneInteractor {
    
    private func checkAllData() {
        guard
            isHaveOccupations,
            isHaveCourses,
            isHaveStatuses,
            isHaveUTMs,
            isHavePositions,
            !occupations.isEmpty,
            !courses.isEmpty,
            !statuses.isEmpty,
            !utms.isEmpty,
            !positions.isEmpty
        else {return}
        var textDict = [String : String]()
        var backDict = [String : String]()
        var num = 0
        for i in occupations {
            textDict[i.name!] = textColors[num % textColors.count].getHex()
            backDict[i.name!] = backgroundColors[num % backgroundColors.count].getHex()
            num += 1
        }
        for i in courses {
            textDict[i.name!] = textColors[num % textColors.count].getHex()
            backDict[i.name!] = backgroundColors[num % backgroundColors.count].getHex()
            num += 1
        }
        for i in statuses {
            textDict[i.name!] = textColors[num % textColors.count].getHex()
            backDict[i.name!] = backgroundColors[num % backgroundColors.count].getHex()
            num += 1
        }
        for i in utms {
            textDict[i.name!] = textColors[num % textColors.count].getHex()
            backDict[i.name!] = backgroundColors[num % backgroundColors.count].getHex()
            num += 1
        }
        for i in positions {
            textDict[i.name!] = textColors[num % textColors.count].getHex()
            backDict[i.name!] = backgroundColors[num % backgroundColors.count].getHex()
            num += 1
        }
        userDefaultsService.saveColors(dict: textDict, As: .theFuckingText)
        userDefaultsService.saveColors(dict: backDict, As: .theFuckingBackground)
        DispatchQueue.main.async { [weak self] in
            self?.output.didGetResponse(response: true)
        }
    }
    
    private func getAll() {
        getOccupations()
        getCourses()
        getUTMs()
        getStatuses()
        getPositions()
    }
    
    private func getOccupations() {
        networkService.sendRequest(
            urlRequest: OccupationController.getOccupations.createURLRequest(),
            successModel: [OccupationModel].self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                self.isHaveOccupations = true
                self.occupations = model
                self.checkAllData()
            case let .badRequest(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .unauthorized(message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, message)
            case let .forbidden(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .notFound(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .methodNotAllowed(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .gone(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .unsupportedMediaType(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .internalServerError(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .notImplemented(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .serviceUnavailable(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case .failure(let error):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, error)
            }
        }
    }
    
    private func getCourses() {
        let request =
            userDefaultsService.isCityBishkek()
            ? BishkekCourseController.getAll.createURLRequest()
            : OshCourseController.getAll.createURLRequest()
        
        networkService.sendRequest(
            urlRequest: request,
            successModel: [CourseModel].self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                self.isHaveCourses = true
                self.courses = model
                self.checkAllData()
            case let .badRequest(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .unauthorized(message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, message)
            case let .forbidden(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .notFound(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .methodNotAllowed(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .gone(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .unsupportedMediaType(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .internalServerError(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .notImplemented(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .serviceUnavailable(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case .failure(let error):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, error)
            }
        }
    }
    
    private func getUTMs() {
        networkService.sendRequest(
            urlRequest: UTMController.getUTMs.createURLRequest(),
            successModel: [UTMModel].self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                self.isHaveUTMs = true
                self.utms = model
                self.checkAllData()
            case let .badRequest(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .unauthorized(message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, message)
            case let .forbidden(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .notFound(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .methodNotAllowed(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .gone(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .unsupportedMediaType(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .internalServerError(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .notImplemented(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .serviceUnavailable(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case .failure(let error):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, error)
            }
        }
    }
    
    private func getStatuses() {
        networkService.sendRequest(
            urlRequest: StatusController.getStatuses.createURLRequest(),
            successModel: [StatusModel].self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                self.isHaveStatuses = true
                self.statuses = model
                self.checkAllData()
            case let .badRequest(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .unauthorized(message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, message)
            case let .forbidden(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .notFound(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .methodNotAllowed(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .gone(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .unsupportedMediaType(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .internalServerError(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .notImplemented(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .serviceUnavailable(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case .failure(let error):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, error)
            }
        }
    }
    
    private func getPositions() {
        networkService.sendRequest(
            urlRequest: PositionController.getAllPositions.createURLRequest(),
            successModel: [PositionModel].self
        ) { [weak self] (result) in
            guard let self = self, let output = self.output else {return}
            switch result {
            case .success(let model):
                self.isHavePositions = true
                self.positions = model
                self.checkAllData()
            case let .badRequest(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .unauthorized(message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, message)
            case let .forbidden(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .notFound(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .methodNotAllowed(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .gone(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .unsupportedMediaType(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case let .internalServerError(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .notImplemented(model):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
            case let .serviceUnavailable(model, message):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, model)
                debugPrint(#function, message)
            case .failure(let error):
                DispatchQueue.main.async {
                    output.didGetResponse(response: false)
                }
                debugPrint(#function, error)
            }
        }
    }
}
