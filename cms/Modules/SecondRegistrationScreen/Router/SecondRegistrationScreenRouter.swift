//
//  SecondRegistrationScreenSecondRegistrationScreenRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 05/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class SecondRegistrationScreenRouter {
    weak var view: SecondRegistrationScreenViewController!
}


// MARK: - Router Input

extension SecondRegistrationScreenRouter: SecondRegistrationScreenRouterInput {
    func openNextModule() {
        let vc = SwinjectStoryboard.createViewController(ThirdRegistrationScreenViewController.self)
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goBack() {
        view.navigationController?.popViewController(animated: true)
    }
}
