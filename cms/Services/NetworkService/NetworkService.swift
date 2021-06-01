//
//  NetworkService.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 12/3/21.
//

import Foundation

class NetworkService {
    
    private var urlSession: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        urlSession = session
    }
    
    func sendRequest<T: Decodable>(
        urlRequest: URLRequest,
        successModel: T.Type,
        completion: @escaping (ProResult<T>) -> ()
    ) {
        urlSession.dataTask(with: urlRequest) {
            [weak self] data, response, error in
            guard let self = self else {
                debugPrint(#function, "Your View Class is dead!")
                return
            }
            if let error = self.validateResponse(data: data, response: response, error: error) {
                if case NetworkErrors.badRequest = error,
                    let model = self.transformFromJSON(data: data, objectType: FailureModel.self) {
                    completion(.badRequest(model))
                } else if case NetworkErrors.unauthorized = error {
                    completion(.unauthorized("Токен умер("))
                } else if case NetworkErrors.forbidden = error,
                    let model = self.transformFromJSON(data: data, objectType: FailureModel.self) {
                    completion(.forbidden(model, "Что-то запрешено"))
                } else if case NetworkErrors.notFound = error,
                    let model = self.transformFromJSON(data: data, objectType: FailureModel.self) {
                    completion(.notFound(model))
                } else if case NetworkErrors.methodNotAllowed = error,
                    let model = self.transformFromJSON(data: data, objectType: FailureModel.self) {
                    completion(.methodNotAllowed(model, "Неправильный HTTPMethod, по крайней мере в бэке..."))
                } else if case NetworkErrors.gone = error,
                    let model = self.transformFromJSON(data: data, objectType: FailureModel.self) {
                    completion(.gone(model))
                } else if case NetworkErrors.unsupportedMediaType = error,
                    let model = self.transformFromJSON(data: data, objectType: FailureModel.self) {
                    completion(.unsupportedMediaType(model, "Что-то ты не правильно отправляешь"))
                } else if case NetworkErrors.internalServerError = error,
                    let model = self.transformFromJSON(data: data, objectType: FailureModel.self) {
                    completion(.internalServerError(model))
                } else if case NetworkErrors.notImplemented = error,
                    let model = self.transformFromJSON(data: data, objectType: FailureModel.self) {
                    completion(.notImplemented(model))
                } else if case NetworkErrors.serviceUnavailable = error,
                    let model = self.transformFromJSON(data: data, objectType: FailureModel.self) {
                    completion(.serviceUnavailable(model, "Бэк помер!"))
                } else {
                    completion(.failure("Упс, что-то пошло не так)"))
                }
            } else if let successModel = self.transformFromJSON(data: data, objectType: T.self) {
                completion(.success(successModel))
            } else {
                debugPrint(#function, "Some supernatural things happened")
            }
        }.resume()
    }
    
    private func validateResponse(data: Data?, response: URLResponse?, error: Error?) -> Error? {
        if let err = error {
            return err
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            return URLError(.badServerResponse)
        }
        switch httpResponse.statusCode {
        case StatusCode.badRequest.code:
            return NetworkErrors.badRequest
        case StatusCode.unauthorized.code:
            return NetworkErrors.unauthorized
        case StatusCode.forbidden.code:
            return NetworkErrors.forbidden
        case StatusCode.notFound.code:
            return NetworkErrors.notFound
        case StatusCode.methodNotAllowed.code:
            return NetworkErrors.methodNotAllowed
        case StatusCode.gone.code:
            return NetworkErrors.gone
        case StatusCode.unsupportedMediaType.code:
            return NetworkErrors.unsupportedMediaType
        case StatusCode.internalServerError.code:
            return NetworkErrors.internalServerError
        case StatusCode.notImplemented.code:
            return NetworkErrors.notImplemented
        case StatusCode.serviceUnavailable.code:
            return NetworkErrors.serviceUnavailable
        default:
            return nil
        }
    }
    
    private func transformFromJSON<T: Decodable>(data: Data?, objectType: T.Type) -> T? {
        guard let data = data else {return nil}
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

