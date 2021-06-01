//
//  ServiceAssembly.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 2/3/21.
//

import Swinject

class ServicesAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(UserDefaultsService.self) { _ in
            .init()
        }
        container.register(NetworkService.self) { _ in
            .init()
        }
    }
}

