//
//  UINavigationController+Extensions.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 2/3/21.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func makeTransparent() -> UINavigationController {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        view.backgroundColor = .clear
//        let BarButtonItemAppearance = UIBarButtonItem.appearance()
//        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        navigationItem.backButtonTitle = " "
        navigationBar.backItem?.title = " "
        navigationItem.backBarButtonItem?.title = " "
        return self
    }
    
    func removeTitle() -> UINavigationController {
        navigationBar.topItem?.title = " "
        return self
    }
    
    func changeTintColor(to color: UIColor) -> UINavigationController {
        navigationBar.tintColor = color
        return self
    }
}
