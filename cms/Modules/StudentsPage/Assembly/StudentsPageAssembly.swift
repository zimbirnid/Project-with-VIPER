//
//  StudentsPageStudentsPageAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 27/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class StudentsPageAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(StudentsPageRouter.self) { (_, viewController: StudentsPageViewController) in
            let router = StudentsPageRouter()
	    router.view = viewController
	    return router
        }
        
        container.register(StudentsPageInteractor.self) { (resolver, presenter: StudentsPagePresenter) in
            let interactor = StudentsPageInteractor(ns: resolver.resolve(NetworkService.self)!, uds: resolver.resolve(UserDefaultsService.self)!)
            interactor.output = presenter    
            return interactor
        }
        
        container.register(StudentsPagePresenter.self) { (resolver, viewController: StudentsPageViewController) in
            let presenter = StudentsPagePresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(StudentsPageInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(StudentsPageRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(StudentsPageViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(StudentsPagePresenter.self, argument: viewController)
        }
    }
}
