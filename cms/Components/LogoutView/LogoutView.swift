//
//  LogoutView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 6/4/21.
//

import UIKit

protocol LogoutViewDelegate {
    func logoutTapped()
}

@IBDesignable
class LogoutView: UIView {
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        view.alpha = 0.5
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissTapped))
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var letterLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.GothamPro.bold.font(size: 20)
        label.textColor = .white
        label.backgroundColor = Colors.MainPage.profileButton.color
        label.layer.cornerRadius = 20
        label.textAlignment = .center
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.GothamPro.medium.font(size: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(Colors.Registration.textDarkGray.color, for: .normal)
        button.titleLabel?.font = Fonts.GothamPro.medium.font(size: 18)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var viewHeightConstraint: NSLayoutConstraint = {
        let const = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        return const
    }()
    
    private lazy var buttonBottomConstraint: NSLayoutConstraint = {
        let const = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -20)
        return const
    }()
    
    private var name = "" {
        didSet {
            nameLabel.text = name
            letterLabel.text = String(name.first ?? "A")
        }
    }
    
    var delegate: LogoutViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(backgroundView)
        addSubview(view)
        addSubview(button)
        view.addSubview(nameLabel)
        view.addSubview(letterLabel)
    }
     
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                backgroundView.topAnchor.constraint(equalTo: topAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                buttonBottomConstraint,
                button.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
                button.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
                button.heightAnchor.constraint(equalToConstant: 40),
                
                view.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -8),
                view.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
                view.heightAnchor.constraint(equalToConstant: 100),
                
                letterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
                letterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                letterLabel.widthAnchor.constraint(equalToConstant: 40),
                letterLabel.heightAnchor.constraint(equalToConstant: 40),
                
                nameLabel.topAnchor.constraint(equalTo: letterLabel.bottomAnchor, constant: 10),
                nameLabel.centerXAnchor.constraint(equalTo: letterLabel.centerXAnchor),
                nameLabel.heightAnchor.constraint(equalToConstant: 20),
            ]
        )
    }
    
    func set(name: String) {
        self.name = name
    }
    
    @objc private func dismissTapped() {
        removeFromSuperview()
    }
    
    @objc private func buttonTapped() {
        delegate?.logoutTapped()
    }
}
