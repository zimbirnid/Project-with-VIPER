//
//  MainPageMainPageAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 15/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class MainPageAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(MainPageRouter.self) { (_, viewController: MainPageViewController) in
            let router = MainPageRouter()
            router.view = viewController
            return router
        }
        
        container.register(MainPageInteractor.self) { (resolver, presenter: MainPagePresenter) in
            let interactor = MainPageInteractor(ns: resolver.resolve(NetworkService.self)!, uds: resolver.resolve(UserDefaultsService.self)!)
            interactor.output = presenter    
            return interactor
        }
        
        container.register(MainPagePresenter.self) { (resolver, viewController: MainPageViewController) in
            let presenter = MainPagePresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(MainPageInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(MainPageRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(MainPageViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(MainPagePresenter.self, argument: viewController)
        }
    }
}
