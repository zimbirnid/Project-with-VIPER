//
//  AddPageAddPageRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 27/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class AddPageRouter {
    weak var view: AddPageViewController!
}


// MARK: - Router Input

extension AddPageRouter: AddPageRouterInput {
    func openPage(at: Int) {
        let vc = SwinjectStoryboard.createViewController(AddPagePersonViewController.self)
        vc.personNumber = at
        view.present(vc, animated: true, completion: nil)
    }
}
