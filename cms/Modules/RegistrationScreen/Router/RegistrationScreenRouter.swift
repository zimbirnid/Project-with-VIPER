//
//  RegistrationScreenRegistrationScreenRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 04/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import SwinjectStoryboard

class RegistrationScreenRouter {
    
    weak var view: RegistrationScreenViewController!

}


// MARK: - Router Input

extension RegistrationScreenRouter: RegistrationScreenRouterInput {
    func openNextModule() {
        let vc = SwinjectStoryboard.createViewController(SecondRegistrationScreenViewController.self)
        vc.removeBackButtonTitle()
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
