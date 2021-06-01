//
//  UIViewController+Extension.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 2/3/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func embeddedInNavigationController() -> UINavigationController {
        return BaseNavigationController(rootViewController: self)
    }
    
    func setNavigationBarAppearance(style: UIBarStyle) {
        navigationController?.navigationBar.barStyle = style
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = .clear
    }
    
    func removeBackButtonTitle() {
        navigationItem.backButtonTitle = ""
    }
    
    func shakeComponent<T: UIView>(component: T) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: component.center.x - 10, y: component.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: component.center.x + 10, y: component.center.y))
        component.layer.add(animation, forKey: "position")
    }
    
    func showAlert(message: String, isOk: Bool) {
        let a = AlertView()
        a.set(icon: isOk ? Icons.Alert.alertImage.image : Icons.Alert.failure.image)
        a.setTitle(text: message)
        a.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(a)
        NSLayoutConstraint.activate(
            [
                a.topAnchor.constraint(equalTo: view.topAnchor),
                a.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                a.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                a.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
        )
    }
}

