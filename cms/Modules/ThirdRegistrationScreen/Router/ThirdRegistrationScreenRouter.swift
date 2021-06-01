//
//  ThirdRegistrationScreenThirdRegistrationScreenRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 09/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class ThirdRegistrationScreenRouter {
    weak var view: ThirdRegistrationScreenViewController!
}


// MARK: - Router Input

extension ThirdRegistrationScreenRouter: ThirdRegistrationScreenRouterInput {
    
    func popToHead() {
        let vcs = view.navigationController?.viewControllers
        view.navigationController?.popToViewController(vcs![vcs!.count - 4], animated: true)
    }
    
    func openNextModule() {
        
    }
    
    func goBack() {
        view.navigationController?.popViewController(animated: true)
    }
}
