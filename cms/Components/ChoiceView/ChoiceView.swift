//
//  ChoiceView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/3/21.
//

import UIKit

@IBDesignable
class ChoiceView: UIView {
    
    private lazy var firstItem: Item = {
        let item = Item()
        item.fill()
        item.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside)
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    private lazy var secondItem: Item = {
        let item = Item()
        item.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside)
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = topText
        label.font = Fonts.GothamPro.regular.font(size: 17)
        label.textColor = Colors.Registration.textDarkGray.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @IBInspectable var topText: String = "" {
        didSet {
            topTitle.text = topText
        }
    }
    
    @IBInspectable var firstText: String = "" {
        didSet {
            firstItem.set(text: firstText)
        }
    }
    
    @IBInspectable var secondText: String = "" {
        didSet {
            secondItem.set(text: secondText)
        }
    }
    
    enum Labels {
        case top
        case others
    }
    
    var isTouchAllowed = true
    private var isFirstFilled = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
        backgroundColor = .clear
    }
    
    private func setupSubviews() {
        addSubview(topTitle)
        addSubview(firstItem)
        addSubview(secondItem)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                firstItem.leadingAnchor.constraint(equalTo: leadingAnchor),
                firstItem.topAnchor.constraint(equalTo: topAnchor),
                firstItem.bottomAnchor.constraint(equalTo: bottomAnchor),
                firstItem.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
                
                secondItem.trailingAnchor.constraint(equalTo: trailingAnchor),
                secondItem.topAnchor.constraint(equalTo: topAnchor),
                secondItem.bottomAnchor.constraint(equalTo: bottomAnchor),
                secondItem.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
                
                topTitle.bottomAnchor.constraint(equalTo: topAnchor, constant: -15),
                topTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            ]
        )
    }
    
    @objc private func tap(_ sender: Item) {
        if isTouchAllowed {
            if sender == firstItem {
                firstItem.fill()
                secondItem.free()
                isFirstFilled = true
            } else if sender == secondItem {
                firstItem.free()
                secondItem.fill()
                isFirstFilled = false
            }
        }
    }
    
    func getSelectedText() -> String {
        return isFirstFilled ? firstText : secondText
    }
    
    func selectCircle(firstCircle: Bool) {
        if firstCircle {
            tap(firstItem)
        } else {
            tap(secondItem)
        }
    }
    
    func change(font: UIFont, For: Labels) {
        switch For {
        case .top:
            topTitle.font = font
        case .others:
            firstItem.set(font: font)
            secondItem.set(font: font)
        }
    }
    
    func change(color: UIColor, For: Labels) {
        switch For {
        case .top:
            topTitle.textColor = color
        case .others:
            firstItem.set(color: color)
            secondItem.set(color: color)
        }
    }
}

extension ChoiceView {
    class Item: UIButton {
        
        private lazy var outLayer: CAShapeLayer = {
            let outLayer = CAShapeLayer()
            outLayer.lineWidth = 2
            outLayer.strokeColor = Colors.Registration.labelColor.color.cgColor
            outLayer.fillColor = UIColor.clear.cgColor
            return outLayer
        }()
        private lazy var inLayer: CAShapeLayer = {
            let inLayer = CAShapeLayer()
            inLayer.fillColor = UIColor.clear.cgColor
            return inLayer
        }()
        
        private lazy var label: UILabel = {
            let label = UILabel()
            label.font = Fonts.GothamPro.regular.font(size: 16)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override func layoutSubviews() {
            super.layoutSubviews()
            setup()
        }
        
        private func setup() {
            setupLayers()
            backgroundColor = .clear
            setupConstraints()
        }
        
        private func setupLayers() {
            layer.addSublayer(inLayer)
            layer.addSublayer(outLayer)
            addSubview(label)
            
            let outPath = UIBezierPath(
                arcCenter:
                    CGPoint(
                        x: 10,
                        y: 15
                    ),
                radius: 10,
                startAngle: 0,
                endAngle: CGFloat(Double.pi * 2),
                clockwise: true
            ).cgPath
            outLayer.path = outPath
            
            let inPath = UIBezierPath(
                arcCenter:
                    CGPoint(
                        x: 10,
                        y: 15
                    ),
                radius: 7,
                startAngle: 0,
                endAngle: CGFloat(Double.pi * 2),
                clockwise: true
            ).cgPath
            inLayer.path = inPath
        }
        
        private func setupConstraints() {
            NSLayoutConstraint.activate(
                [
                    label.topAnchor.constraint(equalTo: topAnchor),
                    label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
                    label.trailingAnchor.constraint(equalTo: trailingAnchor),
                    label.bottomAnchor.constraint(equalTo: bottomAnchor),
                    label.heightAnchor.constraint(equalToConstant: 30)
                ]
            )
        }
        
        func set(text: String) {
            label.text = text
        }
        
        func fill() {
            outLayer.strokeColor = Colors.Registration.purple.color.cgColor
            inLayer.fillColor = Colors.Registration.purple.color.cgColor
        }
        
        func free() {
            outLayer.strokeColor = Colors.Registration.labelColor.color.cgColor
            inLayer.fillColor = UIColor.white.cgColor
        }
        
        func getText() -> String? {
            return label.text
        }
        
        func set(font: UIFont) {
            label.font = font
        }
        func set(color: UIColor) {
            label.textColor = color
        }
    }
}

