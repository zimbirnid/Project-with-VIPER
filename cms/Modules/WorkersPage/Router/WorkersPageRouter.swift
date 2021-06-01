//
//  WorkersPageWorkersPageRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 26/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class WorkersPageRouter {
    weak var view: WorkersPageViewController!
}


// MARK: - Router Input

extension WorkersPageRouter: WorkersPageRouterInput {
    func showFilterPage() {
        let vc = SwinjectStoryboard.createViewController(FilterPageViewController.self)
        vc.currentPage = .worker
        view.present(vc, animated: true, completion: nil)
    }
    
    func logoutTapped() {
        AppUtility.goToAuthentificationPage()
    }
    func cellTapped(with: TeacherModel) {
        let vc = SwinjectStoryboard.createViewController(WorkerDetailViewController.self)
        vc.worker = with
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
