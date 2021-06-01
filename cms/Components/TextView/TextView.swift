//
//  TextView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 26/3/21.
//

import UIKit

@IBDesignable
class TextView: UIView {
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.textColor = Colors.MainPage.darkNameColor.color
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = Colors.MainPage.borderColor.color.cgColor
        textView.font = Fonts.GothamPro.regular.font(size: 16)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 4
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var heightConstraint: NSLayoutConstraint = {
        NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
    }()
    
    private lazy var bottomConstraint: NSLayoutConstraint = {
        NSLayoutConstraint(item: topTitle, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: -15)
    }()
        
    var topText = "" {
        didSet {
            topTitle.text = topText
        }
    }
    
    var height: CGFloat = 30 {
        didSet {
            heightConstraint.constant = height
        }
    }
    
    var titleBottom: CGFloat = -15 {
        didSet {
            bottomConstraint.constant = titleBottom
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(topTitle)
        addSubview(textView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                topTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
                bottomConstraint,
                textView.topAnchor.constraint(equalTo: topAnchor),
                textView.leadingAnchor.constraint(equalTo: leadingAnchor),
                textView.trailingAnchor.constraint(equalTo: trailingAnchor),
                textView.bottomAnchor.constraint(equalTo: bottomAnchor),
                heightConstraint,
            ]
        )
    }
    
    func changeTopText(font: UIFont) {
        topTitle.font = font
    }
    
    func changeBorder(color: UIColor) {
        textView.layer.borderColor = color.cgColor
    }
    
    func getTextView() -> UITextView {
        return textView
    }
    func changeTopText(color: UIColor) {
        topTitle.textColor = color
    }
}
