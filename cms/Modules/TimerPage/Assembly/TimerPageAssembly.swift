//
//  TimerPageTimerPageAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 07/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class TimerPageAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(TimerPageRouter.self) { (_, viewController: TimerPageViewController) in
            let router = TimerPageRouter()
	    router.view = viewController
	    return router
        }
        
        container.register(TimerPageInteractor.self) { (resolver, presenter: TimerPagePresenter) in
            let interactor = TimerPageInteractor(ns: resolver.resolve(NetworkService.self)!, uds: resolver.resolve(UserDefaultsService.self)!)
            interactor.output = presenter    
            return interactor
        }
        
        container.register(TimerPagePresenter.self) { (resolver, viewController: TimerPageViewController) in
            let presenter = TimerPagePresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(TimerPageInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(TimerPageRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(TimerPageViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(TimerPagePresenter.self, argument: viewController)
        }
    }
}
