//
//  FilterPageFilterPageAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 14/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class FilterPageAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(FilterPageRouter.self) { (_, viewController: FilterPageViewController) in
            let router = FilterPageRouter()
	    router.view = viewController
	    return router
        }
        
        container.register(FilterPageInteractor.self) { (resolver, presenter: FilterPagePresenter) in
            let interactor = FilterPageInteractor(ns: resolver.resolve(NetworkService.self)!, uds: resolver.resolve(UserDefaultsService.self)!)
            interactor.output = presenter    
            return interactor
        }
        
        container.register(FilterPagePresenter.self) { (resolver, viewController: FilterPageViewController) in
            let presenter = FilterPagePresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(FilterPageInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(FilterPageRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(FilterPageViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(FilterPagePresenter.self, argument: viewController)
        }
    }
}
