//
//  FilterPageFilterPageRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 14/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class FilterPageRouter {
    weak var view: FilterPageViewController!
}


// MARK: - Router Input

extension FilterPageRouter: FilterPageRouterInput {
    func didGetData(courses: [Int]?, statuses: [Int]?, occupations: [Int]?, positions: [Int]?, utms: [Int]?) {
        guard let tabBar = view.presentingViewController?.children.first as? TabBarViewController else {return}
        if
            let presenter = view.presentingViewController?.children.first?.children[0] as? MainPageViewController,
            tabBar.selectedIndex == 0
        {
            presenter.callFilter(courses: courses, statuses: statuses, occupations: occupations, positions: positions, utms: utms, update: true)
        } else if
            let presenter = view.presentingViewController?.children.first?.children[1] as? ClientsPageViewController,
            tabBar.selectedIndex == 1
        {
            presenter.callFilter(courses: courses, statuses: statuses, occupations: occupations, positions: positions, utms: utms, update: true)
        } else if
            let presenter = view.presentingViewController?.children.first?.children[3] as? WorkersPageViewController,
            tabBar.selectedIndex == 3
        {
            presenter.callFilter(courses: courses, statuses: statuses, occupations: occupations, positions: positions, utms: utms, update: true)
        } else if
            let presenter = view.presentingViewController?.children.first?.children[4] as? StudentsPageViewController,
            tabBar.selectedIndex == 4
        {
            presenter.callFilter(courses: courses, statuses: statuses, occupations: occupations, positions: positions, utms: utms, update: true)
        }
        goBack()
    }
    
    func goBack() {
        view.dismiss(animated: true, completion: nil)
    }
}
