//
//  SegmentView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 16/3/21.
//

import UIKit

@IBDesignable
class SegmentView: UIView {
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
    
    private var items = [UIButton]()
    private var selectedItem = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
        backgroundColor = .white
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
                scrollView.heightAnchor.constraint(equalTo: stackView.heightAnchor, constant: 20),
                
                stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
                stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
                stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
                stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            ]
        )
    }
    
    private func removeItemsFromParent() {
        for i in stackView.subviews {
            i.removeFromSuperview()
        }
    }
    
    func setup(models: [StatusModel]) {
        items = []
        removeItemsFromParent()
        for i in models {
            let button = UIButton()
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            button.setTitle(i.name, for: .normal)
            button.titleLabel?.font = Fonts.GothamPro.medium.font(size: 12)
            button.backgroundColor = Colors.MainPage.segmentBackground.color
            button.setTitleColor(Colors.MainPage.segmentText.color, for: .normal)
            button.tag = i.id ?? 1
            button.layer.cornerRadius = 8
            button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            items.append(button)
            stackView.addArrangedSubview(button)
        }
        tapped(items[0])
    }
    
    func addTargets(_ target: Any?, action: Selector, For: UIControl.Event) {
        for i in items {
            i.addTarget(target, action: action, for: For)
        }
    }
    
    @objc private func tapped(_ sender: UIButton) {
        selectedItem.backgroundColor = Colors.MainPage.segmentBackground.color
        selectedItem.setTitleColor(Colors.MainPage.segmentText.color, for: .normal)
        selectedItem = sender
        sender.backgroundColor = Colors.MainPage.purple.color
        sender.setTitleColor(.white, for: .normal)
    }
    
    func getSelectedItemId() -> String {
        return "\(selectedItem.tag)"
    }
}
