//
//  ThirdRegistrationScreenThirdRegistrationScreenAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 09/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class ThirdRegistrationScreenAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(ThirdRegistrationScreenRouter.self) { (_, viewController: ThirdRegistrationScreenViewController) in
            let router = ThirdRegistrationScreenRouter()
	    router.view = viewController
	    return router
        }
        
        container.register(ThirdRegistrationScreenInteractor.self) { (resolver, presenter: ThirdRegistrationScreenPresenter) in
            let interactor = ThirdRegistrationScreenInteractor(ns: resolver.resolve(NetworkService.self)!, uds: resolver.resolve(UserDefaultsService.self)!)
            interactor.output = presenter    
            return interactor
        }
        
        container.register(ThirdRegistrationScreenPresenter.self) { (resolver, viewController: ThirdRegistrationScreenViewController) in
            let presenter = ThirdRegistrationScreenPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(ThirdRegistrationScreenInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(ThirdRegistrationScreenRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(ThirdRegistrationScreenViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(ThirdRegistrationScreenPresenter.self, argument: viewController)
        }
    }
}
