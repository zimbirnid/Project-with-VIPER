//
//  AuthenticationOneAuthenticationOneAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 02/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class AuthenticationOneAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(AuthenticationOneRouter.self) { (_, viewController: AuthenticationOneViewController) in
            let router = AuthenticationOneRouter()
            router.view = viewController
            return router
        }
        
        container.register(AuthenticationOneInteractor.self) { (resolver, presenter: AuthenticationOnePresenter) in
            let interactor = AuthenticationOneInteractor(userDefaults: resolver.resolve(UserDefaultsService.self)!, network: resolver.resolve(NetworkService.self)!)
            interactor.output = presenter
            return interactor
        }
        
        container.register(AuthenticationOnePresenter.self) { (resolver, viewController: AuthenticationOneViewController) in
            let presenter = AuthenticationOnePresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(AuthenticationOneInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(AuthenticationOneRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(AuthenticationOneViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(AuthenticationOnePresenter.self, argument: viewController)
        }
    }
}
