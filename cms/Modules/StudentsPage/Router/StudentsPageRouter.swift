//
//  StudentsPageStudentsPageRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 27/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class StudentsPageRouter {
    weak var view: StudentsPageViewController!
}


// MARK: - Router Input

extension StudentsPageRouter: StudentsPageRouterInput {
    func showFilterPage() {
        let vc = SwinjectStoryboard.createViewController(FilterPageViewController.self)
        vc.currentPage = .student
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
}
