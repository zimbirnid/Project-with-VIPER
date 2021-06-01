//
//  MainCard.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 20/3/21.
//

import UIKit

@IBDesignable
class MainCard: UICollectionViewCell {

    private lazy var occupationLabel: LabelWithPadding = {
        let label = LabelWithPadding()
        label.layer.cornerRadius = 4
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.backgroundColor = Colors.MainPage.purpleButtonBackground.color
        label.textColor = Colors.MainPage.purple.color
        label.setInsets(top: 2, bottom: 2, left: 8, right: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.textAlignment = .center
        label.textColor = Colors.MainPage.darkNameColor.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var programmingLangLabel: LabelWithPadding = {
        let label = LabelWithPadding()
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.textAlignment = .center
        label.setInsets(top: 2, bottom: 2, left: 8, right: 8)
        label.backgroundColor = Colors.MainPage.programmingLangBackground.color
        label.textColor = Colors.MainPage.programmingLang.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.textAlignment = .center
        label.textColor = Colors.MainPage.dateColor.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var sourceLabel: LabelWithPadding = {
        let label = LabelWithPadding()
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.textAlignment = .center
        label.setInsets(top: 2, bottom: 2, left: 8, right: 8)
        label.backgroundColor = Colors.MainPage.sourceBackground.color
        label.textColor = Colors.MainPage.source.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.textAlignment = .left
        label.textColor = Colors.MainPage.borderColor.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var commentIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.MainPage.comment.image
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(Icons.MainPage.threeDots.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.MainPage.borderColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sourceLabelNormalLeadingConstraint: NSLayoutConstraint = {
        sourceLabel.leadingAnchor.constraint(equalTo: programmingLangLabel.trailingAnchor, constant: 8)
    }()
    
    private lazy var sourceLabelAbnormalLeadingConstraint: NSLayoutConstraint = {
        sourceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
    }()
    
    private var hasCourse = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
        setupShadow()
    }
    
    private func setupShadow() {
        layer.cornerRadius = 8.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
    }
    
    private func setupSubviews() {
        addSubview(occupationLabel)
        addSubview(nameLabel)
        addSubview(numberLabel)
        addSubview(programmingLangLabel)
        addSubview(dateLabel)
        addSubview(sourceLabel)
        addSubview(commentIcon)
        addSubview(commentLabel)
        addSubview(lineView)
        addSubview(button)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                occupationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
                occupationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                occupationLabel.heightAnchor.constraint(equalToConstant: 20),

                nameLabel.topAnchor.constraint(equalTo: occupationLabel.bottomAnchor, constant: 10),
                nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                nameLabel.heightAnchor.constraint(equalToConstant: 20),

                numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
                numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                numberLabel.heightAnchor.constraint(equalToConstant: 20),

                programmingLangLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10),
                programmingLangLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                programmingLangLabel.heightAnchor.constraint(equalToConstant: 20),

                sourceLabel.topAnchor.constraint(equalTo: programmingLangLabel.topAnchor),
                sourceLabel.heightAnchor.constraint(equalToConstant: 20),

                dateLabel.topAnchor.constraint(equalTo: programmingLangLabel.topAnchor),
                dateLabel.heightAnchor.constraint(equalToConstant: 20),
                dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),

                lineView.topAnchor.constraint(equalTo: programmingLangLabel.bottomAnchor, constant: 10),
                lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                lineView.heightAnchor.constraint(equalToConstant: 1),

                commentIcon.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
                commentIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                commentIcon.heightAnchor.constraint(equalToConstant: 20),
                commentIcon.widthAnchor.constraint(equalToConstant: 20),

                commentLabel.leadingAnchor.constraint(equalTo: commentIcon.trailingAnchor, constant: 8),
                commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                commentLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
                commentLabel.heightAnchor.constraint(equalToConstant: 20),
                
                button.heightAnchor.constraint(equalToConstant: 30),
                button.widthAnchor.constraint(equalToConstant: 30),
                button.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            ]
        )
        if hasCourse {
            sourceLabelAbnormalLeadingConstraint.isActive = false
            sourceLabelNormalLeadingConstraint.isActive = true
        } else {
            sourceLabelNormalLeadingConstraint.isActive = false
            sourceLabelAbnormalLeadingConstraint.isActive = true
        }
    }

    func configure(model: ClientModel) {
        button.tag = model.clientID!
        occupationLabel.text = model.occupation?.name
        nameLabel.text = (model.name ?? "") + " " + (model.surname ?? "")
        numberLabel.text = model.phoneNo?.toBestStyle()
        programmingLangLabel.text = model.course?.name
        sourceLabel.text = model.utm?.name
        commentLabel.text = model.description
        dateLabel.text = configureTime(string: model.timer)
        
        programmingLangLabel.setFuckingColors()
        occupationLabel.setFuckingColors()
        sourceLabel.setFuckingColors()
        numberLabel.setPhoneNumberColor()
        configureLeadingConstraints()
    }
    
    private func configureLeadingConstraints() {
        if programmingLangLabel.text == nil || programmingLangLabel.text == "" {
            hasCourse = false
        } else {
            hasCourse = true
        }
        setNeedsLayout()
    }
    
    func addTargetToButton(_ target: Any?, action: Selector, For: UIControl.Event) {
        button.addTarget(target, action: action, for: For)
    }
}

