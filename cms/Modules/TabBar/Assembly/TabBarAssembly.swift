//
//  TabBarTabBarAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 15/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class TabBarAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(TabBarRouter.self) { (_, viewController: TabBarViewController) in
            let router = TabBarRouter()
	    router.view = viewController
	    return router
        }
        
        container.register(TabBarInteractor.self) { (_, presenter: TabBarPresenter) in
            let interactor = TabBarInteractor()
            interactor.output = presenter    
            return interactor
        }
        
        container.register(TabBarPresenter.self) { (resolver, viewController: TabBarViewController) in
            let presenter = TabBarPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(TabBarInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(TabBarRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(TabBarViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(TabBarPresenter.self, argument: viewController)
        }
    }
}