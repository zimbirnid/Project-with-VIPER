//
//  SecondRegistrationScreenSecondRegistrationScreenAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 05/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class SecondRegistrationScreenAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(SecondRegistrationScreenRouter.self) { (_, viewController: SecondRegistrationScreenViewController) in
            let router = SecondRegistrationScreenRouter()
	    router.view = viewController
	    return router
        }
        
        container.register(SecondRegistrationScreenInteractor.self) { (resolver, presenter: SecondRegistrationScreenPresenter) in
            let interactor = SecondRegistrationScreenInteractor(userDefaultsService: resolver.resolve(UserDefaultsService.self)!)
            interactor.output = presenter    
            return interactor
        }
        
        container.register(SecondRegistrationScreenPresenter.self) { (resolver, viewController: SecondRegistrationScreenViewController) in
            let presenter = SecondRegistrationScreenPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(SecondRegistrationScreenInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(SecondRegistrationScreenRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(SecondRegistrationScreenViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(SecondRegistrationScreenPresenter.self, argument: viewController)
        }
    }
}
