//
//  RestorePasswordScreenRestorePasswordScreenRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 10/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class RestorePasswordScreenRouter {
    weak var view: RestorePasswordScreenViewController!
}


// MARK: - Router Input

extension RestorePasswordScreenRouter: RestorePasswordScreenRouterInput {

    func goBack() {
        guard let vcs = view.navigationController?.viewControllers else {return}
        view.navigationController?.popToViewController(vcs[vcs.count - 3], animated: true)
    }
}
