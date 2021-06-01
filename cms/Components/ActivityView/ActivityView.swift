//
//  ActivityView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 22/4/21.
//

import UIKit

@IBDesignable
class ActivityView: UIView {
    
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var activity: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = Colors.MainPage.purple.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(view)
        addSubview(activity)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: topAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                activity.topAnchor.constraint(equalTo: topAnchor),
                activity.leadingAnchor.constraint(equalTo: leadingAnchor),
                activity.trailingAnchor.constraint(equalTo: trailingAnchor),
                activity.bottomAnchor.constraint(equalTo: bottomAnchor),
            ]
        )
    }
    
    override func didMoveToSuperview() {
        activity.startAnimating()
    }
    
    func removeThisView() {
        activity.stopAnimating()
        removeFromSuperview()
    }
    
    func changeBackground(color: UIColor) {
        view.backgroundColor = color
    }
}
