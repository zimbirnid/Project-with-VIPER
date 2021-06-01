//
//  AuthenticationOneAuthenticationOneRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 02/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import SwinjectStoryboard

class AuthenticationOneRouter {
    
    weak var view: AuthenticationOneViewController!
}


// MARK: - Router Input

extension AuthenticationOneRouter: AuthenticationOneRouterInput {
    func openRegisterPage() {
        let vc = SwinjectStoryboard.createViewController(RegistrationScreenViewController.self)
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openNextModule() {
        let vc = SwinjectStoryboard.createViewController(TabBarViewController.self)
            .embeddedInNavigationController()
            .changeTintColor(to: Colors.MainPage.purple.color)
            .removeTitle()
            .makeTransparent()
        AppUtility.makeRoot(viewController: vc)
    }
    
    func openForgetPage() {
        let vc = SwinjectStoryboard.createViewController(ForgotPasswordScreenViewController.self)
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
