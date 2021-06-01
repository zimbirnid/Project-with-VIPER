//
//  MainPageMainPageRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 15/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class MainPageRouter {
    weak var view: MainPageViewController!
}


// MARK: - Router Input

extension MainPageRouter: MainPageRouterInput {
    func showFilterPage() {
        let vc = SwinjectStoryboard.createViewController(FilterPageViewController.self)
        vc.currentPage = .main
        view.present(vc, animated: true, completion: nil)
    }
    
    func logoutTapped() {
        AppUtility.goToAuthentificationPage()
    }
    
    func cellTapped(with: ClientModel) {
        let vc = SwinjectStoryboard.createViewController(MainCardDetailViewController.self)
        vc.client = with
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func timerPressed(client: ClientModel) {
        let vc = SwinjectStoryboard.createViewController(TimerPageViewController.self)
        vc.client = client
        view.present(vc, animated: true, completion: nil)
    }
    
    
}
