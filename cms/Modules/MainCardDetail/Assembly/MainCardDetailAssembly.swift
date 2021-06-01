//
//  MainCardDetailMainCardDetailAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 23/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class MainCardDetailAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(MainCardDetailRouter.self) { (_, viewController: MainCardDetailViewController) in
            let router = MainCardDetailRouter()
	    router.view = viewController
	    return router
        }
        
        container.register(MainCardDetailInteractor.self) { (resolver, presenter: MainCardDetailPresenter) in
            let interactor = MainCardDetailInteractor(ns: resolver.resolve(NetworkService.self)!, uds: resolver.resolve(UserDefaultsService.self)!)
            interactor.output = presenter    
            return interactor
        }
        
        container.register(MainCardDetailPresenter.self) { (resolver, viewController: MainCardDetailViewController) in
            let presenter = MainCardDetailPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(MainCardDetailInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(MainCardDetailRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(MainCardDetailViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(MainCardDetailPresenter.self, argument: viewController)
        }
    }
}
