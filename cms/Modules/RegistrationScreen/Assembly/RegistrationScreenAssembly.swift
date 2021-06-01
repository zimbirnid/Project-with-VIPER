//
//  RegistrationScreenRegistrationScreenAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 04/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class RegistrationScreenAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(RegistrationScreenRouter.self) { (_, viewController: RegistrationScreenViewController) in
            let router = RegistrationScreenRouter()
            router.view = viewController
            return router
        }
        
        container.register(RegistrationScreenInteractor.self) { (resolver, presenter: RegistrationScreenPresenter) in
            let interactor = RegistrationScreenInteractor(userDefaultsService: resolver.resolve(UserDefaultsService.self)!)
            interactor.output = presenter    
            return interactor
        }
        
        container.register(RegistrationScreenPresenter.self) { (resolver, viewController: RegistrationScreenViewController) in
            let presenter = RegistrationScreenPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(RegistrationScreenInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(RegistrationScreenRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(RegistrationScreenViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(RegistrationScreenPresenter.self, argument: viewController)
        }
    }
}
