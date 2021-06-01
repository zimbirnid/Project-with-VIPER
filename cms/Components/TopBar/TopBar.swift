//
//  TopBar.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 16/3/21.
//

import UIKit

protocol TopBarDelegate {
    func profileButtonTapped()
    func notificationButtonTapped()
}

@IBDesignable
class TopBar: UIView {
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = Icons.MainPage.logo.image
        image.tintColor = Colors.Registration.purple.color
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.GothamPro.medium.font(size: 22)
        label.textAlignment = .left
        label.textColor = Colors.MainPage.title.color
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var profileButton: UIButton = {
        let button = UIButton()
        button.tintColor = Colors.MainPage.borderColor.color
        button.titleLabel?.font = Fonts.GothamPro.bold.font(size: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.MainPage.profileButton.color
        button.layer.cornerRadius = frame.height / 2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var notificationButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Icons.MainPage.notificationOff.image, for: .normal)
        button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var name = ""
    private var shouldShowNotificationButton = true
    
    var delegate: TopBarDelegate?
   
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupContstraints()
        backgroundColor = .white
    }
    
    private func setupSubviews() {
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(profileButton)
        if shouldShowNotificationButton {
            addSubview(notificationButton)
        }
    }
    
    private func setupContstraints() {
        NSLayoutConstraint.activate(
            [
                logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                logoImageView.topAnchor.constraint(equalTo: topAnchor),
                logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                logoImageView.heightAnchor.constraint(equalToConstant: 30),
                logoImageView.widthAnchor.constraint(equalToConstant: 30),
                
                titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 20),
                titleLabel.topAnchor.constraint(equalTo: topAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
               
                profileButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                profileButton.topAnchor.constraint(equalTo: topAnchor),
                profileButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                profileButton.heightAnchor.constraint(equalToConstant: 30),
                profileButton.widthAnchor.constraint(equalToConstant: 30),
            ]
        )
        if shouldShowNotificationButton {
            NSLayoutConstraint.activate(
                [
                    notificationButton.trailingAnchor.constraint(equalTo: profileButton.leadingAnchor, constant: -10),
                    notificationButton.topAnchor.constraint(equalTo: topAnchor),
                    notificationButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                    notificationButton.heightAnchor.constraint(equalToConstant: 30),
                    notificationButton.widthAnchor.constraint(equalToConstant: 30),
                ]
            )
        }
    }
    
    @objc private func tapped(_ sender: UIButton) {
        if sender == notificationButton {
            delegate?.notificationButtonTapped()
        } else if sender == profileButton {
            delegate?.profileButtonTapped()
        }
    }
    
    func didGetNotifications() {
        notificationButton.setBackgroundImage(Icons.MainPage.notificationOn.image, for: .normal)
        UIView.animate(withDuration: 1/3) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    func dismissNotification() {
        notificationButton.setBackgroundImage(Icons.MainPage.notificationOff.image, for: .normal)
        UIView.animate(withDuration: 1/3) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    func setProfileLetter(name: String) {
        self.name = name
        profileButton.setTitle("\(name.prefix(1))", for: .normal)
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func removeNotificationIcon() {
        shouldShowNotificationButton = false
        setNeedsLayout()
    }
}
