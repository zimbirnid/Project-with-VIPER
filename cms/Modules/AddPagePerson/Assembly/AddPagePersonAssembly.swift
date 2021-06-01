//
//  AddPagePersonAddPagePersonAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 03/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class AddPagePersonAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(AddPagePersonRouter.self) { (_, viewController: AddPagePersonViewController) in
            let router = AddPagePersonRouter()
            router.view = viewController
            return router
        }
        
        container.register(AddPagePersonInteractor.self) { (resolver, presenter: AddPagePersonPresenter) in
            let interactor = AddPagePersonInteractor(ns: resolver.resolve(NetworkService.self)!, uds: resolver.resolve(UserDefaultsService.self)!)
            interactor.output = presenter
            return interactor
        }
        
        container.register(AddPagePersonPresenter.self) { (resolver, viewController: AddPagePersonViewController) in
            let presenter = AddPagePersonPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(AddPagePersonInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(AddPagePersonRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(AddPagePersonViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(AddPagePersonPresenter.self, argument: viewController)
        }
    }
}
