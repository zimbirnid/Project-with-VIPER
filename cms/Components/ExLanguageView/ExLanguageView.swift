//
//  ExLanguageView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 17/4/21.
//

import UIKit

@IBDesignable
class ExLanguageView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var items = [String]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                scrollView.topAnchor.constraint(equalTo: topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                scrollView.leftAnchor.constraint(equalTo: leftAnchor),
                scrollView.rightAnchor.constraint(equalTo: rightAnchor),
                scrollView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
                
                stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
                stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            ]
        )
    }
    
    private func removeItemsFromStack() {
        for i in stackView.subviews {
            i.removeFromSuperview()
        }
    }
    
    func set(data: [String]) {
        items = []
        removeItemsFromStack()
        for i in data {
            let label = LabelWithPadding()
            label.setInsets(top: 2, bottom: 2, left: 8, right: 8)
            label.text = i
            label.font = Fonts.GothamPro.medium.font(size: 16)
            label.backgroundColor = .gray//
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.heightAnchor.constraint(equalToConstant: 24).isActive = true
            items.append(i)
            stackView.addArrangedSubview(label)
        }
    }
}
