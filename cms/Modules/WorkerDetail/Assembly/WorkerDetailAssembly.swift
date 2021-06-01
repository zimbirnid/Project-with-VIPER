//
//  WorkerDetailWorkerDetailAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 11/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class WorkerDetailAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(WorkerDetailRouter.self) { (_, viewController: WorkerDetailViewController) in
            let router = WorkerDetailRouter()
	    router.view = viewController
	    return router
        }
        
        container.register(WorkerDetailInteractor.self) { (resolver, presenter: WorkerDetailPresenter) in
            let interactor = WorkerDetailInteractor(ns: resolver.resolve(NetworkService.self)!, uds: resolver.resolve(UserDefaultsService.self)!)
            interactor.output = presenter    
            return interactor
        }
        
        container.register(WorkerDetailPresenter.self) { (resolver, viewController: WorkerDetailViewController) in
            let presenter = WorkerDetailPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(WorkerDetailInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(WorkerDetailRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(WorkerDetailViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(WorkerDetailPresenter.self, argument: viewController)
        }
    }
}
