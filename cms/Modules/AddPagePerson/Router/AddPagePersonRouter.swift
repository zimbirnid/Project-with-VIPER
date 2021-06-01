//
//  AddPagePersonAddPagePersonRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 03/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class AddPagePersonRouter {
    weak var view: AddPagePersonViewController!
}


// MARK: - Router Input

extension AddPagePersonRouter: AddPagePersonRouterInput {
    func pop() {
        guard let presenter = view.presentingViewController?.children.first?.children[2] as? AddPageViewController else {return}
        view.dismiss(animated: true, completion: nil)
        presenter.didCancelTapped()
    }
}
