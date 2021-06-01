//
//  UILabel+Extensions.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 19/4/21.
//

import SwinjectStoryboard
import UIKit

fileprivate let userDefaultsService = SwinjectStoryboard.defaultContainer.resolve(UserDefaultsService.self)!

extension UILabel {
    func setFuckingColors() {
        backgroundColor = .white
        textColor = .black
        if let text = text {
            if let back = userDefaultsService.getColors(As: .theFuckingBackground)[text] {
                backgroundColor = back.getColorFromHex()
            } else {
                backgroundColor = .white
            }
            if let back = userDefaultsService.getColors(As: .theFuckingText)[text] {
                textColor = back.getColorFromHex()
            } else {
                textColor = .black
            }
        }
    }
    
    func setPhoneNumberColor() {
        textColor = "#636363".getColorFromHex()
    }
}
