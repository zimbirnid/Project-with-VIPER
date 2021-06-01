//
//  ClientsPageClientsPageAssembly.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 26/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import Swinject

class ClientsPageAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(ClientsPageRouter.self) { (_, viewController: ClientsPageViewController) in
            let router = ClientsPageRouter()
	    router.view = viewController
	    return router
        }
        
        container.register(ClientsPageInteractor.self) { (resolver, presenter: ClientsPagePresenter) in
            let interactor = ClientsPageInteractor(ns: resolver.resolve(NetworkService.self)!, uds: resolver.resolve(UserDefaultsService.self)!)
            interactor.output = presenter    
            return interactor
        }
        
        container.register(ClientsPagePresenter.self) { (resolver, viewController: ClientsPageViewController) in
            let presenter = ClientsPagePresenter()
            presenter.view = viewController
            presenter.interactor = resolver.resolve(ClientsPageInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(ClientsPageRouter.self, argument: viewController)
            return presenter
        }
        
        container.storyboardInitCompleted(ClientsPageViewController.self) { resolver, viewController in
            viewController.output = resolver.resolve(ClientsPagePresenter.self, argument: viewController)
        }
    }
}
