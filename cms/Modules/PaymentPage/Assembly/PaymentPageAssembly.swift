//
//  PaymentPagePaymentPageAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 20/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class PaymentPageAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(PaymentPageRouter.self) { (_, viewController: PaymentPageViewController) in
            let router = PaymentPageRouter()
	    router.view = viewController
	    return router
        }
        
        container.register(PaymentPageInteractor.self) { (resolver, presenter: PaymentPagePresenter) in
            let interactor = PaymentPageInteractor(ns: resolver.resolve(NetworkService.self)!, uds: resolver.resolve(UserDefaultsService.self)!)
            interactor.output = presenter    
            return interactor
        }
        
        container.register(PaymentPagePresenter.self) { (resolver, viewController: PaymentPageViewController) in
            let presenter = PaymentPagePresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(PaymentPageInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(PaymentPageRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(PaymentPageViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(PaymentPagePresenter.self, argument: viewController)
        }
    }
}
