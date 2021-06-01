//
//  AppUtility.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 23/3/21.
//

import SwinjectStoryboard

struct AppUtility {
    
    static func makeRoot(viewController: UIViewController) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.makeRoot(viewController: viewController)
        }
    }
    static func goToAuthentificationPage() {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            let vc = SwinjectStoryboard.createViewController(AuthenticationOneViewController.self)
                .embeddedInNavigationController()
                .makeTransparent()
                .changeTintColor(to: Colors.Registration.purple.color)
                .removeTitle()
            let userDefaultsService = SwinjectStoryboard.defaultContainer.resolve(UserDefaultsService.self)!
            userDefaultsService.save(token: nil)
            delegate.makeRoot(viewController: vc)
        }
    }
}
