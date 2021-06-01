//
//  AlertView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 9/3/21.
//

import UIKit

protocol AlertViewDelegate {
    func didSelfRemoved()
}

@IBDesignable
class AlertView: UIView {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        view.alpha = 0.5
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeView))
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var view: Alert = {
        let view = Alert()
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeView))
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var delegate: AlertViewDelegate?
    
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
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                backgroundView.topAnchor.constraint(equalTo: topAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                view.centerXAnchor.constraint(equalTo: centerXAnchor),
                view.centerYAnchor.constraint(equalTo: centerYAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.77),
            ]
        )
    }
    
    @objc private func removeView() {
        removeFromSuperview()
        delegate?.didSelfRemoved()
    }
    
    func setTitle(text: String) {
        view.setTitle(text: text)
    }
    
    func set(icon: UIImage) {
        view.set(icon: icon)
    }
    
    private class Alert: UIView {
        private lazy var label: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.textAlignment = .center
            label.numberOfLines = 0
            label.font = Fonts.GothamPro.regular.font(size: 20)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = Icons.Alert.alertImage.image
            imageView.backgroundColor = .clear
            imageView.tintColor = Colors.Registration.purple.color
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        private lazy var rightImage: UIImageView = {
            let imageView = UIImageView()
            imageView.image = Icons.TextFieldIcons.x.image
            imageView.tintColor = Colors.Registration.iconDarkGray.color
            imageView.backgroundColor = .clear
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        override func layoutSubviews() {
            super.layoutSubviews()
            setup()
        }
        
        private func setup() {
            setupSubviews()
            setupConstraints()
            
            backgroundColor = Colors.Registration.backgroundAlert.color
            layer.cornerRadius = 4
        }
        
        private func setupSubviews() {
            addSubview(label)
            addSubview(imageView)
            addSubview(rightImage)
        }
        
        private func setupConstraints() {
            NSLayoutConstraint.activate(
                [
                    imageView.heightAnchor.constraint(equalToConstant: 70),
                    imageView.widthAnchor.constraint(equalToConstant: 70),
                    imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
                    imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                    
                    label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
                    label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                    label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                    
                    rightImage.topAnchor.constraint(equalTo: topAnchor, constant: 15),
                    rightImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                    rightImage.heightAnchor.constraint(equalToConstant: 30),
                    rightImage.widthAnchor.constraint(equalToConstant: 30),
                ]
            )
        }
        
        func setTitle(text: String) {
            label.text = text
        }
        
        func set(icon: UIImage) {
            imageView.image = icon
        }
    }
}
