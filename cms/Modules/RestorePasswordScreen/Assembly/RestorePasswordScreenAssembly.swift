//
//  RestorePasswordScreenRestorePasswordScreenAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 10/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class RestorePasswordScreenAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(RestorePasswordScreenRouter.self) { (_, viewController: RestorePasswordScreenViewController) in
            let router = RestorePasswordScreenRouter()
	    router.view = viewController
	    return router
        }
        
        container.register(RestorePasswordScreenInteractor.self) { (_, presenter: RestorePasswordScreenPresenter) in
            let interactor = RestorePasswordScreenInteractor()
            interactor.output = presenter    
            return interactor
        }
        
        container.register(RestorePasswordScreenPresenter.self) { (resolver, viewController: RestorePasswordScreenViewController) in
            let presenter = RestorePasswordScreenPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(RestorePasswordScreenInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(RestorePasswordScreenRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(RestorePasswordScreenViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(RestorePasswordScreenPresenter.self, argument: viewController)
        }
    }
}