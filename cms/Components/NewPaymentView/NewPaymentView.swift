//
//  NewPaymentView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 20/4/21.
//

import UIKit

protocol NewPaymentViewDelegate {
    func didGet(model: PaymentsPostModel)
    func cancelTapped()
}

@IBDesignable
class NewPaymentView: UIView {
    
    private lazy var monthView: DropDownView = {
        let view = DropDownView()
        view.topText = "Месяц:"
        view.height = 36
        view.set(data: ["Январь","Февраль","Март","Апрель","Июнь","Июль","Август","Сентябрь","Октябрь","Ноябрь","Декабрь"])
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.set(text: "Январь")
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 14))
        view.changeLabel(font: Fonts.GothamPro.regular.font(size: 16))
        view.leftPadding = 15
        view.leftLabelPadding = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var methodView: DropDownView = {
        let view = DropDownView()
        view.topText = "Метод:"
        view.height = 36
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 14))
        view.changeLabel(font: Fonts.GothamPro.regular.font(size: 16))
        view.leftPadding = 15
        view.leftLabelPadding = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sumTextField: TextField = {
        let textfield = TextField()
        textfield.topTitleText = "Сумма оплаты:"
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 14), For: .top)
        textfield.changeTitleColors(topTitleColor: Colors.MainCardDetail.label.color, bottomTitleColor: Colors.MainCardDetail.label.color)
        textfield.setRightIcon(image: Icons.ClientsPage.som.image)
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = Colors.MainPage.borderColor.color.cgColor
        textfield.layer.cornerRadius = 4
        textfield.keyboardType = .numberPad
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var saveButton: EnterButton = {
        let button = EnterButton()
        button.cornerRadius = 4
        button.changeBackgroundColor(color: Colors.MainPage.purple.color)
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = Fonts.GothamPro.medium.font(size: 14)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cancelButton: EnterButton = {
        let button = EnterButton()
        button.cornerRadius = 4
        button.isInverseColor = true
        button.setTitle("Сбросить", for: .normal)
        button.titleLabel?.font = Fonts.GothamPro.medium.font(size: 14)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var data = [MethodModel]() {
        didSet {
            let a = data.map({$0.name!})
            methodView.set(data: a)
            methodView.set(text: a.first)
        }
    }
    
    var delegate: NewPaymentViewDelegate?

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
        layer.cornerRadius = 20
        backgroundColor = .white
    }
    
    private func setupSubviews() {
        addSubview(monthView)
        addSubview(methodView)
        addSubview(sumTextField)
        addSubview(saveButton)
        addSubview(cancelButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                monthView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
                monthView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                monthView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                
                methodView.topAnchor.constraint(equalTo: monthView.bottomAnchor, constant: 50),
                methodView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                methodView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                
                sumTextField.topAnchor.constraint(equalTo: methodView.bottomAnchor, constant: 50),
                sumTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                sumTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                sumTextField.heightAnchor.constraint(equalToConstant: 36),
                
                saveButton.topAnchor.constraint(equalTo: sumTextField.bottomAnchor, constant: 20),
                saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                saveButton.heightAnchor.constraint(equalToConstant: 40),
                
                cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
                cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                cancelButton.heightAnchor.constraint(equalToConstant: 40),
                cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            ]
        )
    }
    
    @objc private func buttonTapped(_ sender: EnterButton) {
        if sender == saveButton {
            guard
                let sum = sumTextField.text, !sum.isEmpty,
                let id = data.filter({$0.name == methodView.getText()}).last?.id
            else {
                shakeComponent(component: sumTextField)
                let color = Colors.Registration.red.color
                sumTextField.changeBorder(color: color)
                sumTextField.changeTitleColors(topTitleColor: color, bottomTitleColor: color)
                return
            }
            delegate?.didGet(model: PaymentsPostModel(done: false, methodID: id, month: monthView.getText(), price: Int(sum)))
        } else {
            delegate?.cancelTapped()
        }
    }
    
    func set(data: [MethodModel]) {
        self.data = data
    }
}
