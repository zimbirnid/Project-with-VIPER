//
//  ClientsPageClientsPageRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 26/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class ClientsPageRouter {
    weak var view: ClientsPageViewController!
}


// MARK: - Router Input

extension ClientsPageRouter: ClientsPageRouterInput {
    func showFilterPage() {
        let vc = SwinjectStoryboard.createViewController(FilterPageViewController.self)
        vc.currentPage = .client
        view.present(vc, animated: true, completion: nil)
    }
    
    func logoutTapped() {
        AppUtility.makeRoot(viewController: SwinjectStoryboard.createViewController(AuthenticationOneViewController.self))
    }
    
    func cellTapped(with: ClientModel) {
        let vc = SwinjectStoryboard.createViewController(MainCardDetailViewController.self)
        vc.client = with
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
