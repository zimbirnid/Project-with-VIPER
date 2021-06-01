//
//  ForgotPasswordScreenForgotPasswordScreenRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 10/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class ForgotPasswordScreenRouter {
    weak var view: ForgotPasswordScreenViewController!
}


// MARK: - Router Input

extension ForgotPasswordScreenRouter: ForgotPasswordScreenRouterInput {
    func openNextModule() {
        let vc = SwinjectStoryboard.createViewController(RestorePasswordScreenViewController.self)
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func accountHaveTapped() {
        view.navigationController?.popViewController(animated: true)
    }
}
