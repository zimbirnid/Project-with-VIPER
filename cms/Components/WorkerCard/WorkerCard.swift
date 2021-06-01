//
//  WorkerCard.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 26/3/21.
//

import UIKit

@IBDesignable
class WorkerCard: UICollectionViewCell {
    
    private lazy var occupationLabel: LabelWithPadding = {
        let label = LabelWithPadding()
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.textAlignment = .center
        label.setInsets(top: 2, bottom: 2, left: 8, right: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var programmingLangLabel: LabelWithPadding = {
        let label = LabelWithPadding()
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.textAlignment = .center
        label.setInsets(top: 2, bottom: 2, left: 8, right: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.font = Fonts.GothamPro.bold.font(size: 14)
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
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.font = Fonts.GothamPro.bold.font(size: 14)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private func setupSubviews() {
        addSubview(occupationLabel)
        addSubview(programmingLangLabel)
        addSubview(nameLabel)
        addSubview(numberLabel)
        addSubview(emailLabel)
    }
    
    private func setupShadow() {
        layer.cornerRadius = 8.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                occupationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
                occupationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                occupationLabel.heightAnchor.constraint(equalToConstant: 20),
                
                programmingLangLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
                programmingLangLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                programmingLangLabel.heightAnchor.constraint(equalToConstant: 20),
                
                nameLabel.topAnchor.constraint(equalTo: programmingLangLabel.bottomAnchor, constant: 10),
                nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                nameLabel.heightAnchor.constraint(equalToConstant: 20),
                
                numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
                numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                numberLabel.heightAnchor.constraint(equalToConstant: 20),
                
                emailLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10),
                emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                emailLabel.heightAnchor.constraint(equalToConstant: 20),
            ]
        )
    }
    
    func configure(model: TeacherModel) {
        programmingLangLabel.text = model.courseName
        occupationLabel.text = model.position
        nameLabel.text = model.name
        numberLabel.text = model.phoneNo?.toBestStyle()
        emailLabel.text = model.email
        programmingLangLabel.setFuckingColors()
        occupationLabel.setFuckingColors()
        if ["менеджер", "маркетолог"].contains(model.position?.lowercased()) {
            programmingLangLabel.backgroundColor = .white
            programmingLangLabel.textColor = .white
        }
        numberLabel.setPhoneNumberColor()
    }
}
