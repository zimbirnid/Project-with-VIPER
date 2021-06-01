//
//  ClientCard.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 26/3/21.
//

import UIKit

@IBDesignable
class ClientCard: UICollectionViewCell {
    
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

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.textAlignment = .center
        label.textColor = .black
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
        label.backgroundColor = Colors.MainPage.purple.color
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusLabel: LabelWithPadding = {
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

    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.MainPage.borderColor.color
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
        addSubview(nameLabel)
        addSubview(programmingLangLabel)
        addSubview(sourceLabel)
        addSubview(statusLabel)
        addSubview(commentIcon)
        addSubview(commentLabel)
        addSubview(lineView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                programmingLangLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
                programmingLangLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                programmingLangLabel.heightAnchor.constraint(equalToConstant: 20),
                
                statusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
                statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                statusLabel.heightAnchor.constraint(equalToConstant: 20),
                
                nameLabel.topAnchor.constraint(equalTo: programmingLangLabel.bottomAnchor, constant: 10),
                nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                nameLabel.heightAnchor.constraint(equalToConstant: 20),
                
                sourceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
                sourceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                sourceLabel.heightAnchor.constraint(equalToConstant: 20),
                
                lineView.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 10),
                lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                lineView.heightAnchor.constraint(equalToConstant: 1),
                
                commentIcon.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
                commentIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                commentIcon.heightAnchor.constraint(equalToConstant: 20),
                commentIcon.widthAnchor.constraint(equalToConstant: 20),

                commentLabel.leadingAnchor.constraint(equalTo: commentIcon.trailingAnchor, constant: 8),
                commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                commentLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
                commentLabel.heightAnchor.constraint(equalToConstant: 20),
            ]
        )
    }

    func configure(model: ClientModel) {
        nameLabel.text = (model.name ?? "") + " " + (model.surname ?? "")
        programmingLangLabel.text = model.course?.name
        statusLabel.text = model.status?.name
        sourceLabel.text = model.utm?.name
        commentLabel.text = model.description
        
        programmingLangLabel.setFuckingColors()
        sourceLabel.setFuckingColors()
        statusLabel.setFuckingColors()
    }
}
