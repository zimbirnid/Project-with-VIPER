//
//  AppDelegate.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 2/3/21.
//

import UIKit
import Swinject
import SwinjectStoryboard
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 100
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
        IQKeyboardManager.shared.overrideKeyboardAppearance = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.toolbarTintColor = .label
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Готово"

        window = UIWindow(frame: UIScreen.main.bounds)
        let userDefaultsService = SwinjectStoryboard.defaultContainer.resolve(UserDefaultsService.self)!
        if userDefaultsService.isHaveToken() {
            let vc = SwinjectStoryboard.createViewController(TabBarViewController.self)
                .embeddedInNavigationController()
                .changeTintColor(to: Colors.MainPage.purple.color)
                .removeTitle()
                .makeTransparent()
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        } else {
            let vc = SwinjectStoryboard.createViewController(AuthenticationOneViewController.self)
                .embeddedInNavigationController()
                .makeTransparent()
                .changeTintColor(to: Colors.Registration.purple.color)
                .removeTitle()
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
        return true
    }
    
    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        if extensionPointIdentifier == UIApplication.ExtensionPointIdentifier.keyboard {
            return false
        }
        return true
    }
    
    func makeRoot(viewController: UIViewController) {
        window?.rootViewController?.removeFromParent()
        self.window?.rootViewController = viewController
    }
}
