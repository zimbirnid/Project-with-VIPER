//
//  UIView+Extensions.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/3/21.
//

import UIKit

extension UIView {
    
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissTheView))
        addGestureRecognizer(tap)
    }
    
    @objc private func dismissTheView() {
        endEditing(true)
    }
    
    
    func compareImages(one: UIImage?, two: UIImage?) -> Bool {
        guard let one = one,
              let two = two,
              let oneData = one.pngData(),
              let twoData = two.pngData()
        else {return false}
        return oneData == twoData
    }
    
    func compareDates(date: String) -> ComparisonResult {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = formatter.date(from: date)
        let now = Date()
        return date!.compare(now)
    }
    
    func configureTime(string: String?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.locale = Locale(identifier: "ru")
        let data = formatter.date(from: string ?? "")
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        var returningDate = ""
        if let data = data {
            returningDate = formatter.string(from: data)
        }
        return returningDate
    }
    
    func rotate(by: CGFloat) {
        UIView.animate(withDuration: 1/3) { [weak self] in
            guard let self = self else {return}
            self.transform = CGAffineTransform(rotationAngle: by)
        }
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
    
    
}
