//
//  WorkersPageWorkersPageAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 26/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class WorkersPageAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(WorkersPageRouter.self) { (_, viewController: WorkersPageViewController) in
            let router = WorkersPageRouter()
	    router.view = viewController
	    return router
        }
        
        container.register(WorkersPageInteractor.self) { (resolver, presenter: WorkersPagePresenter) in
            let interactor = WorkersPageInteractor(ns: resolver.resolve(NetworkService.self)!, uds: resolver.resolve(UserDefaultsService.self)!)
            interactor.output = presenter    
            return interactor
        }
        
        container.register(WorkersPagePresenter.self) { (resolver, viewController: WorkersPageViewController) in
            let presenter = WorkersPagePresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(WorkersPageInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(WorkersPageRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(WorkersPageViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(WorkersPagePresenter.self, argument: viewController)
        }
    }
}
