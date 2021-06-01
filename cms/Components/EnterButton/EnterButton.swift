//
//  EnterButton.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 3/3/21.
//

import Foundation
import UIKit

@IBDesignable
class EnterButton: UIButton {
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var isInverseColor: Bool = false {
        didSet {
            configureColors()
        }
    }
    
    @IBInspectable var isActive: Bool = false {
        didSet {
            setEnable()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureColors()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setup() {
        configureTitle()
    }
    
    private func configureColors() {
        if isInverseColor {
            backgroundColor = Colors.Registration.white.color
            tintColor = Colors.Registration.purple.color
            setTitleColor(Colors.Registration.purple.color, for: .normal)
            layer.borderWidth = 1
            layer.borderColor = Colors.Registration.purple.color.cgColor
        } else {
            backgroundColor = Colors.Registration.purple.color
            tintColor = Colors.Registration.white.color
            setTitleColor(.white, for: .normal)
            layer.borderWidth = 0
            layer.borderColor = Colors.Registration.white.color.cgColor
        }
    }
    
    private func configureTitle() {
        titleLabel?.font = Fonts.GothamPro.black.font(size: 20)
    }
    
    private func setEnable() {
        isEnabled = isActive
        if isEnabled {
            configureColors()
        } else {
            changeBackgroundColor(color: Colors.Registration.borderColor.color)
            changeTextColor(color: Colors.Registration.white.color)
        }
    }
    
    func changeBackgroundColor(color: UIColor) {
        backgroundColor = color
    }
    
    func changeTextColor(color: UIColor) {
        tintColor = color
    }
}
