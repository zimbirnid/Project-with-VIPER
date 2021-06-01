//
//  TabBarTabBarPresenter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 15/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

class TabBarPresenter {
    weak var view: TabBarViewInput!
    var interactor: TabBarInteractorInput!
    var router: TabBarRouterInput!
}


// MARK: - Module Input

extension TabBarPresenter: TabBarModuleInput {}


// MARK: - View Output

extension TabBarPresenter: TabBarViewOutput {
    func viewIsReady() {
        view.setupInitialState()
    }
}


// MARK: - Interactor Output

extension TabBarPresenter: TabBarInteractorOutput {

}
