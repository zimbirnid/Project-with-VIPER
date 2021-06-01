//
//  StudentCard.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 27/3/21.
//

import UIKit

@IBDesignable
class StudentCard: UICollectionViewCell {
    
    private lazy var programmingLangLabel: LabelWithPadding = {
        let label = LabelWithPadding()
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.textAlignment = .center
        label.sizeToFit()
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
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.StudentsPage.studentCardIcon.image
        imageView.backgroundColor = .clear
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
        setupShadow()
    }
    
    private func setupSubviews() {
        addSubview(programmingLangLabel)
        addSubview(nameLabel)
        addSubview(icon)
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                programmingLangLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
                programmingLangLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                programmingLangLabel.heightAnchor.constraint(equalToConstant: 20),
                
                nameLabel.topAnchor.constraint(equalTo: programmingLangLabel.bottomAnchor, constant: 10),
                nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                nameLabel.heightAnchor.constraint(equalToConstant: 20),
                
                icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                icon.heightAnchor.constraint(equalToConstant: 20),
                icon.widthAnchor.constraint(equalToConstant: 20),
                icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            ]
        )
    }
    
    private func setupShadow() {
        layer.cornerRadius = 8.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
    }
    
    func configure(model: ClientModel) {
        programmingLangLabel.text = model.course?.name
        nameLabel.text = ((model.name ?? "") + " " ?? "") + (model.surname ?? "")
        programmingLangLabel.setFuckingColors()
    }
}
