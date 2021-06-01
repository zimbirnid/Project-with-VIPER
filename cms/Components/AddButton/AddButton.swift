//
//  AddButton.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 21/3/21.
//

import UIKit

@IBDesignable
class AddButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
        setupShadow()
    }
    
    private func setup() {
        layer.cornerRadius = 8
        titleLabel?.font = Fonts.GothamPro.medium.font(size: 14)
        setTitleColor(Colors.MainPage.borderColor.color, for: .normal)
        backgroundColor = .white
        setTitle("+ Добавить", for: .normal)
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
    }
}
