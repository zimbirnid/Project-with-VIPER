//
//  AddPageAddPageAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 27/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class AddPageAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(AddPageRouter.self) { (_, viewController: AddPageViewController) in
            let router = AddPageRouter()
	    router.view = viewController
	    return router
        }
        
        container.register(AddPageInteractor.self) { (resolver, presenter: AddPagePresenter) in
            let interactor = AddPageInteractor()
            interactor.output = presenter    
            return interactor
        }
        
        container.register(AddPagePresenter.self) { (resolver, viewController: AddPageViewController) in
            let presenter = AddPagePresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(AddPageInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(AddPageRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(AddPageViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(AddPagePresenter.self, argument: viewController)
        }
    }
}
