//
//  ForgotPasswordScreenForgotPasswordScreenAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 10/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class ForgotPasswordScreenAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(ForgotPasswordScreenRouter.self) { (_, viewController: ForgotPasswordScreenViewController) in
            let router = ForgotPasswordScreenRouter()
            router.view = viewController
            return router
        }
        
        container.register(ForgotPasswordScreenInteractor.self) { (resolver, presenter: ForgotPasswordScreenPresenter) in
            let interactor = ForgotPasswordScreenInteractor(ns: resolver.resolve(NetworkService.self)!, uds: resolver.resolve(UserDefaultsService.self)!)
            interactor.output = presenter    
            return interactor
        }
        
        container.register(ForgotPasswordScreenPresenter.self) { (resolver, viewController: ForgotPasswordScreenViewController) in
            let presenter = ForgotPasswordScreenPresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(ForgotPasswordScreenInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(ForgotPasswordScreenRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(ForgotPasswordScreenViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(ForgotPasswordScreenPresenter.self, argument: viewController)
        }
    }
}
