//
//  ProcessView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 3/3/21.
//

import Foundation
import UIKit

@IBDesignable
class ProcessView: UIView {
    
    
    private let firstItem = Square()
    private let secondItem = Square()
    private let thirdItem = Square()
    
    
    // MARK: - IBInspectable var
    
    @IBInspectable var select: Int = 0 {
        didSet {
            choose(item: select)
        }
    }
    
    @IBInspectable var firstText: String = "" {
        didSet {
            setItem(at: 1)
        }
    }
   
    @IBInspectable var secondText: String = "" {
        didSet {
            setItem(at: 2)
        }
    }
    
    @IBInspectable var thirdText: String = "" {
        didSet {
            setItem(at: 3)
        }
    }
    
    
    // MARK: - INITS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let length = frame.size.height
        setupSquares(length: length)
    }
    
    
    // MARK: - Setup Square
    
    private func setupSquares(length: CGFloat) {
        let x: CGFloat = 0
        let xx: CGFloat = frame.width/3
        let xxx: CGFloat = xx*2
        
        firstItem.frame = CGRect(x: x, y: 0, width: xx, height: length)
        firstItem.setText(number: 1)
        addSubview(firstItem)
        
        secondItem.frame = CGRect(x: xx, y: 0, width: xx, height: length)
        secondItem.setText(number: 2)
        addSubview(secondItem)
        
        thirdItem.frame = CGRect(x: xxx, y: 0, width: xx, height: length)
        thirdItem.setText(number: 3)
        addSubview(thirdItem)
        setupLine()
    }
    
    
    // MARK: - Setup Middle Line
    
    private func setupLine() {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        let height = firstItem.frame.height*1/3
        let labelHalfWidth = firstItem.frame.height/3
        path.move(to:
                    CGPoint(
                        x: firstItem.frame.width/2 + labelHalfWidth,
                        y: height
                    )
        )
        path.addLine(to:
                        CGPoint(
                            x: firstItem.frame.width + secondItem.frame.width/2 - labelHalfWidth,
                            y: height
                        )
        )
        path.move(to:
                    CGPoint(
                        x: secondItem.frame.width + secondItem.frame.width/2 + labelHalfWidth,
                        y: height
                    )
        )
        path.addLine(to:
                        CGPoint(
                            x: firstItem.frame.width + secondItem.frame.width + thirdItem.frame.width/2 - labelHalfWidth,
                            y: height
                        )
        )
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 3
        shapeLayer.strokeColor = Colors.Registration.borderColor.color.cgColor
        layer.addSublayer(shapeLayer)
    }
    
    func choose(item: Int) {
        let gray = Colors.Registration.borderColor.color
        let purple = Colors.Registration.purple.color
        if item == 1 {
            firstItem.changeBackground(color: purple)
            secondItem.changeBackground(color: gray)
            thirdItem.changeBackground(color: gray)
        } else if item == 2 {
            firstItem.changeBackground(color: gray)
            secondItem.changeBackground(color: purple)
            thirdItem.changeBackground(color: gray)
        } else if item == 3 {
            firstItem.changeBackground(color: gray)
            secondItem.changeBackground(color: gray)
            thirdItem.changeBackground(color: purple)
        }
    }
    
    private func setItem(at: Int) {
        switch at {
        case 1:
            firstItem.setBottom(text: firstText)
        case 2:
            secondItem.setBottom(text: secondText)
        case 3:
            thirdItem.setBottom(text: thirdText)
        default:
            break
        }
    }

    private class Square: UIView {
        let label = UILabel()
        private let bottomTitle = UILabel()
        var leftPoint = CGPoint()
        var rightPoint = CGPoint()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setup()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            setup()
        }
        
        
        // MARK: - Setup
        
        private func setup() {
            setupLabel()
            setCornerRadius(radius: 4)
        }
        
        
        // MARK: - Setup Label
        
        private func setupLabel() {
            let lableLength = frame.height*2/3
            label.frame = CGRect(x: frame.width/2 - lableLength/2, y: 0, width: lableLength, height: lableLength)
            label.textColor = Colors.Registration.white.color
            label.font = Fonts.GothamPro.regular.font(size: 17)
            label.textAlignment = .center
            label.clipsToBounds = true
            
            leftPoint = CGPoint(x: label.frame.minX, y: lableLength/2)
            leftPoint = CGPoint(x: label.frame.maxX, y: lableLength/2)
            addSubview(label)
            
            bottomTitle.frame = CGRect(x: 0, y: lableLength, width: frame.width, height: lableLength)
            bottomTitle.textColor = Colors.Registration.black.color
            bottomTitle.font = Fonts.GothamPro.regular.font(size: 14)
            bottomTitle.textAlignment = .center
            bottomTitle.numberOfLines = 0
            addSubview(bottomTitle)
        }
        
        
        // MARK: - Change Background
        
        func changeBackground(color: UIColor) {
            label.backgroundColor = color
        }
        
        
        // MARK: - Set Label Text
        
        func setText(number: Int) {
            label.text = "\(number)"
        }
        
        
        func setBottom(text: String) {
            bottomTitle.text = text
        }
        
        
        // MARK: - Set Corner Radius
        
        private func setCornerRadius(radius: CGFloat) {
            label.layer.cornerRadius = radius
        }
    }
}
