//
//  UserDefaultsService.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 12/3/21.
//
import UIKit
import Foundation

class UserDefaultsService {
    
    enum Keys: String {
        case Authorization
        case name
        case city
    }
    
    enum Authority: String {
        case authority
    }
    
    enum CreteUser: String {
        case CreateUserCity
        case CreateUserEmail
        case CreateUserName
        case CreateUserPassword
        case CreateUserPatronymic
        case CreateUserPhoneNo
        case CreateUserPosition
        case CreateUserSurname
    }
    private enum Authentification: String {
        case email
        case password
    }
    
    enum TheFuckingColors: String {
        case theFuckingText
        case theFuckingBackground
    }
    
    private let storage: UserDefaults
    
    required init(storage: UserDefaults = UserDefaults.standard) {
        self.storage = storage
    }
    
    func getToken() -> String? {
        storage.value(forKey: Keys.Authorization.rawValue) as? String
    }
    func getKey(key: Keys) -> String {
        return key.rawValue
    }
    func save(token: String?) {
        if let token = token {
            storage.setValue("Bearer " + token, forKey: Keys.Authorization.rawValue)
        } else {
            storage.setValue(nil, forKey: Keys.Authorization.rawValue)
        }
    }
    func saveUser(name: String?) {
        storage.setValue(name, forKey: Keys.name.rawValue)
    }
    
    func getByKey(key: Keys) -> String {
        return storage.value(forKey: key.rawValue) as! String
    }
    func saveCreateUser(value: String, key: CreteUser) {
        storage.setValue(value, forKey: key.rawValue)
    }
    func getCreatedUserValue(byKey: CreteUser) -> String {
        return storage.value(forKey: byKey.rawValue) as! String
    }
    func saveCity(isBishkek: Bool) {
        storage.setValue(isBishkek, forKey: Keys.city.rawValue)
    }
    func isCityBishkek() -> Bool {
        storage.value(forKey: Keys.city.rawValue) as! Bool
    }
    func saveAuthority(isAdmid: Bool) {
        storage.setValue(isAdmid, forKey: Authority.authority.rawValue)
    }
    func isAdmin() -> Bool {
        return storage.value(forKey: Authority.authority.rawValue) as! Bool
    }
    func saveAuth(email: String, password: String) {
        storage.setValue(email, forKey: Authentification.email.rawValue)
        storage.setValue(password, forKey: Authentification.password.rawValue)
    }
    func getAuth() -> (String, String) {
        let email = storage.value(forKey: Authentification.email.rawValue) as! String
        let password = storage.value(forKey: Authentification.password.rawValue) as! String
        return (email, password)
    }
    func isHaveToken() -> Bool {
        if let _ = storage.value(forKey: Keys.Authorization.rawValue) as? String {
            return true
        }
        return false
    }
    
    func saveColors(dict: [String: String], As: TheFuckingColors) {
        storage.setValue(dict, forKey: As.rawValue)
    }
    
    func getColors(As: TheFuckingColors) -> [String: String] {
        return storage.value(forKey: As.rawValue) as? [String: String] ?? [:]
    }
}
