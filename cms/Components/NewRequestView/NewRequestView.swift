//
//  NewRequestView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 27/3/21.
//

import UIKit

protocol NewRequestViewDelegate {
    func didGetClient(data: Data)
    func cancelTapped()
}

@IBDesignable

class NewRequestView: UIView {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.dismissKeyboard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = Fonts.GothamPro.medium.font(size: 22)
        label.text = "Новая заявка"
        label.textAlignment = .center
        label.sizeToFit()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var personalInfoLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.text = "Личная информация:"
        label.textAlignment = .center
        label.sizeToFit()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var surnameTextField: TextField = {
        let textfield = TextField()
        textfield.topTitleText = "Фамилия:"
        textfield.cornerRadius = 4
        textfield.changeTitleColors(topTitleColor: Colors.MainCardDetail.label.color, bottomTitleColor: Colors.MainCardDetail.label.color)
        textfield.font = Fonts.GothamPro.regular.font(size: 14)
        textfield.changeBorder(color: Colors.MainPage.borderColor.color)
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var nameTextField: TextField = {
        let textfield = TextField()
        textfield.topTitleText = "Имя:"
        textfield.cornerRadius = 4
        textfield.changeTitleColors(topTitleColor: Colors.MainCardDetail.label.color, bottomTitleColor: Colors.MainCardDetail.label.color)
        textfield.font = Fonts.GothamPro.regular.font(size: 14)
        textfield.changeBorder(color: Colors.MainPage.borderColor.color)
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var fathernameTextField: TextField = {
        let textfield = TextField()
        textfield.topTitleText = "Отчество:"
        textfield.cornerRadius = 4
        textfield.font = Fonts.GothamPro.regular.font(size: 14)
        textfield.changeTitleColors(topTitleColor: Colors.MainCardDetail.label.color, bottomTitleColor: Colors.MainCardDetail.label.color)
        textfield.changeBorder(color: Colors.MainPage.borderColor.color)
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var contactInfoLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.text = "Контактная информация:"
        label.textAlignment = .center
        label.sizeToFit()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberTextField: TextField = {
        let textfield = TextField()
        textfield.textContentType = .telephoneNumber
        textfield.keyboardType = .numberPad
        textfield.topTitleText = "Телефон:"
        textfield.cornerRadius = 4
        textfield.font = Fonts.GothamPro.regular.font(size: 14)
        textfield.changeTitleColors(topTitleColor: Colors.MainCardDetail.label.color, bottomTitleColor: Colors.MainCardDetail.label.color)
        textfield.changeBorder(color: Colors.MainPage.borderColor.color)
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var statusView: DropDownView = {
        let view = DropDownView()
        view.topText = "Статус:"
        view.height = 30
        view.delegate = self
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 12))
        view.changeLabel(font: Fonts.GothamPro.regular.font(size: 14))
        view.changeCellText(font: Fonts.GothamPro.regular.font(size: 14))
        view.leftPadding = 15
        view.leftLabelPadding = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var educationLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.text = "Обучение:"
        label.textAlignment = .center
        label.sizeToFit()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var courseView: DropDownView = {
        let view = DropDownView()
        view.topText = "Курс:"
        view.height = 30
        view.delegate = self
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 12))
        view.changeLabel(font: Fonts.GothamPro.regular.font(size: 14))
        view.changeCellText(font: Fonts.GothamPro.regular.font(size: 14))
        view.leftPadding = 15
        view.leftLabelPadding = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var typeView: DropDownView = {
        let view = DropDownView()
        view.topText = "Тип:"
        view.height = 30
        view.delegate = self
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 12))
        view.changeLabel(font: Fonts.GothamPro.regular.font(size: 14))
        view.changeCellText(font: Fonts.GothamPro.regular.font(size: 14))
        view.leftPadding = 15
        view.leftLabelPadding = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var experienceView: ChoiceView = {
        let view = ChoiceView()
        view.topText = "Опыт:"
        view.change(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        view.change(font: Fonts.GothamPro.regular.font(size: 14), For: .others)
        view.change(color: Colors.MainCardDetail.label.color, For: .top)
        view.firstText = "Да"
        view.secondText = "Нет"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var thirdView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var targetView: DropDownView = {
        let view = DropDownView()
        view.topText = "Цель обучение:"
        view.height = 30
        view.delegate = self
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 12))
        view.changeLabel(font: Fonts.GothamPro.regular.font(size: 14))
        view.changeCellText(font: Fonts.GothamPro.regular.font(size: 14))
        view.leftPadding = 15
        view.leftLabelPadding = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fourthView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.text = "Дополнительная информация:"
        label.textAlignment = .center
        label.sizeToFit()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sourceView: DropDownView = {
        let view = DropDownView()
        view.topText = "Источник:"
        view.height = 30
        view.delegate = self
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 12))
        view.changeLabel(font: Fonts.GothamPro.regular.font(size: 14))
        view.changeCellText(font: Fonts.GothamPro.regular.font(size: 14))
        view.leftPadding = 15
        view.leftLabelPadding = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var laptopView: ChoiceView = {
        let view = ChoiceView()
        view.topText = "Ноутбук:"
        view.change(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        view.change(font: Fonts.GothamPro.regular.font(size: 14), For: .others)
        view.change(color: Colors.MainCardDetail.label.color, For: .top)
        view.firstText = "Да"
        view.secondText = "Нет"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fifthView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.dismissKeyboard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var commentTextView: TextView = {
        let view = TextView()
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 12))
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.topText = "Комментарий:"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var saveButton: EnterButton = {
        let button = EnterButton()
        button.cornerRadius = 4
        button.changeBackgroundColor(color: Colors.MainPage.purple.color)
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = Fonts.GothamPro.medium.font(size: 14)
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cancelButton: EnterButton = {
        let button = EnterButton()
        button.cornerRadius = 4
        button.isInverseColor = true
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        button.setTitleColor(Colors.MainPage.purple.color, for: .normal)
        button.setTitle("Отменить", for: .normal)
        button.titleLabel?.font = Fonts.GothamPro.medium.font(size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var scrollViewTopConstraint: NSLayoutConstraint = {
        let const = NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: backgroundView, attribute: .top, multiplier: 1, constant: 0)
        return const
    }()
    
    enum Datas {
        case status
        case course
        case source
        case type
        case target
    }
    
    var delegate: NewRequestViewDelegate?
    
    private var statusData = [StatusModel]() {
        didSet {
            let a = statusData.map{$0.name!}
            statusView.set(data: a)
        }
    }
    
    private var courseData = [CourseModel]() {
        didSet {
            let a = courseData.map{$0.name!}
            courseView.set(data: a)
        }
    }
    
    private var sourceData = [UTMModel]() {
        didSet {
            let a = sourceData.map{$0.name!}
            sourceView.set(data: a)
        }
    }
    
    private var typeData = [OccupationModel]() {
        didSet {
            let a = typeData.map{$0.name!}
            typeView.set(data: a)
        }
    }
    
    private var targetData = [TargetModel]() {
        didSet {
            let a = targetData.map{$0.name!}
            targetView.set(data: a)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
        configureTextfields()
        configureTextViews()
    }
    
    private func setupSubviews() {
        backgroundColor = .clear
        addSubview(backgroundView)
        addSubview(scrollView)
        scrollView.addSubview(centerView)
        
        centerView.addSubview(firstView)
        firstView.addSubview(title)
        firstView.addSubview(personalInfoLabel)
        firstView.addSubview(surnameTextField)
        firstView.addSubview(nameTextField)
        firstView.addSubview(fathernameTextField)
        firstView.addSubview(contactInfoLabel)
        firstView.addSubview(numberTextField)
        
        centerView.addSubview(secondView)
        secondView.addSubview(statusView)
        secondView.addSubview(educationLabel)
        secondView.addSubview(courseView)
        secondView.addSubview(typeView)
        secondView.addSubview(experienceView)
        
        centerView.addSubview(thirdView)
        thirdView.addSubview(targetView)
        
        centerView.addSubview(fourthView)
        fourthView.addSubview(additionalInfoLabel)
        fourthView.addSubview(sourceView)
        fourthView.addSubview(laptopView)
        
        centerView.addSubview(fifthView)
        fifthView.addSubview(commentTextView)
        fifthView.addSubview(cancelButton)
        fifthView.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                backgroundView.topAnchor.constraint(equalTo: topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                scrollViewTopConstraint,
                scrollView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 0),
                
                centerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
                centerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                centerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                centerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                centerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
                
                firstView.topAnchor.constraint(equalTo: centerView.topAnchor),
                firstView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
                firstView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),
                
                title.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 20),
                title.centerXAnchor.constraint(equalTo: firstView.centerXAnchor),

                personalInfoLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 25),
                personalInfoLabel.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 20),

                surnameTextField.topAnchor.constraint(equalTo: personalInfoLabel.bottomAnchor, constant: 40),
                surnameTextField.leadingAnchor.constraint(equalTo: personalInfoLabel.leadingAnchor),
                surnameTextField.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
                surnameTextField.heightAnchor.constraint(equalToConstant: 30),

                nameTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 40),
                nameTextField.leadingAnchor.constraint(equalTo: surnameTextField.leadingAnchor),
                nameTextField.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
                nameTextField.heightAnchor.constraint(equalToConstant: 30),

                fathernameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
                fathernameTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
                fathernameTextField.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
                fathernameTextField.heightAnchor.constraint(equalToConstant: 30),

                contactInfoLabel.topAnchor.constraint(equalTo: fathernameTextField.bottomAnchor, constant: 25),
                contactInfoLabel.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 20),
                contactInfoLabel.heightAnchor.constraint(equalToConstant: 30),

                numberTextField.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 40),
                numberTextField.leadingAnchor.constraint(equalTo: contactInfoLabel.leadingAnchor),
                numberTextField.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
                numberTextField.heightAnchor.constraint(equalToConstant: 30),
                numberTextField.bottomAnchor.constraint(equalTo: firstView.bottomAnchor),

                secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor),
                secondView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
                secondView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),

                statusView.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 40),
                statusView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20),
                statusView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -20),

                educationLabel.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 25),
                educationLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20),
                educationLabel.heightAnchor.constraint(equalToConstant: 30),

                courseView.topAnchor.constraint(equalTo: educationLabel.bottomAnchor, constant: 40),
                courseView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20),
                courseView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -20),

                typeView.topAnchor.constraint(equalTo: courseView.bottomAnchor, constant: 40),
                typeView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20),
                typeView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -20),

                experienceView.topAnchor.constraint(equalTo: typeView.bottomAnchor, constant: 40),
                experienceView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20),
                experienceView.widthAnchor.constraint(equalToConstant: 200),
                experienceView.bottomAnchor.constraint(equalTo: secondView.bottomAnchor),

                thirdView.topAnchor.constraint(equalTo: secondView.bottomAnchor),
                thirdView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
                thirdView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),

                targetView.topAnchor.constraint(equalTo: thirdView.topAnchor, constant: 40),
                targetView.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 20),
                targetView.trailingAnchor.constraint(equalTo: thirdView.trailingAnchor, constant: -20),
                targetView.bottomAnchor.constraint(equalTo: thirdView.bottomAnchor),

                fourthView.topAnchor.constraint(equalTo: thirdView.bottomAnchor),
                fourthView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
                fourthView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),

                additionalInfoLabel.topAnchor.constraint(equalTo: fourthView.topAnchor, constant: 25),
                additionalInfoLabel.leadingAnchor.constraint(equalTo: fourthView.leadingAnchor, constant: 20),
                additionalInfoLabel.heightAnchor.constraint(equalToConstant: 30),

                sourceView.topAnchor.constraint(equalTo: additionalInfoLabel.bottomAnchor, constant: 40),
                sourceView.leadingAnchor.constraint(equalTo: fourthView.leadingAnchor, constant: 20),
                sourceView.trailingAnchor.constraint(equalTo: fourthView.trailingAnchor, constant: -20),

                laptopView.topAnchor.constraint(equalTo: sourceView.bottomAnchor, constant: 40),
                laptopView.leadingAnchor.constraint(equalTo: fourthView.leadingAnchor, constant: 20),
                laptopView.widthAnchor.constraint(equalToConstant: 200),
                laptopView.bottomAnchor.constraint(equalTo: fourthView.bottomAnchor),

                fifthView.topAnchor.constraint(equalTo: fourthView.bottomAnchor),
                fifthView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
                fifthView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),

                commentTextView.topAnchor.constraint(equalTo: laptopView.bottomAnchor, constant: 40),
                commentTextView.leadingAnchor.constraint(equalTo: fifthView.leadingAnchor, constant: 20),
                commentTextView.trailingAnchor.constraint(equalTo: fifthView.trailingAnchor, constant: -20),
                
                saveButton.topAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: 20),
                saveButton.leadingAnchor.constraint(equalTo: fifthView.leadingAnchor, constant: 20),
                saveButton.trailingAnchor.constraint(equalTo: fifthView.trailingAnchor, constant: -20),
                saveButton.heightAnchor.constraint(equalToConstant: 36),
                
                cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
                cancelButton.leadingAnchor.constraint(equalTo: fifthView.leadingAnchor, constant: 20),
                cancelButton.trailingAnchor.constraint(equalTo: fifthView.trailingAnchor, constant: -20),
                cancelButton.heightAnchor.constraint(equalToConstant: 36),
                cancelButton.bottomAnchor.constraint(equalTo: fifthView.bottomAnchor, constant: -100),
                
                
                fifthView.bottomAnchor.constraint(equalTo: centerView.bottomAnchor),
            ]
        )
    }
    
    private func configureTextfields() {
        surnameTextField.delegate = self
        nameTextField.delegate = self
        fathernameTextField.delegate = self
        numberTextField.delegate = self
    }
    
    private func configureTextViews() {
        commentTextView.getTextView().delegate = self
    }
    
    private func setInitialBorderColors() {
        let color = Colors.MainPage.borderColor.color
        let titlecolor = Colors.MainCardDetail.label.color
        surnameTextField.changeTitleColors(topTitleColor: titlecolor, bottomTitleColor: titlecolor)
        nameTextField.changeTitleColors(topTitleColor: titlecolor, bottomTitleColor: titlecolor)
        fathernameTextField.changeTitleColors(topTitleColor: titlecolor, bottomTitleColor: titlecolor)
        numberTextField.changeTitleColors(topTitleColor: titlecolor, bottomTitleColor: titlecolor)
        
        surnameTextField.buttonImage = nil
        nameTextField.buttonImage = nil
        fathernameTextField.buttonImage = nil
        numberTextField.buttonImage = nil
        
        surnameTextField.changeBorder(color: color)
        nameTextField.changeBorder(color: color)
        fathernameTextField.changeBorder(color: color)
        numberTextField.changeBorder(color: color)
        statusView.changeBorder(color: color)
        courseView.changeBorder(color: color)
        typeView.changeBorder(color: color)
        targetView.changeBorder(color: color)
        sourceView.changeBorder(color: color)
        commentTextView.changeBorder(color: color)
    }
    
    private func noDataIn(textField: TextField? = nil, textView: TextView? = nil, dropDown: DropDownView? = nil, datePicker: DatePickerView? = nil) {
        if let textField = textField {
            shakeComponent(component: textField)
            textField.changeTitleColors(topTitleColor: Colors.Registration.red.color, bottomTitleColor: Colors.Registration.red.color)
            textField.changeBorder(color: Colors.Registration.red.color)
            textField.buttonImage = Icons.TextFieldIcons.x.image
            textField.changeButtonTint(color: Colors.Registration.red.color)
        } else if let textView = textView {
            shakeComponent(component: textView)
            textView.changeTopText(color: Colors.Registration.red.color)
            textView.changeBorder(color: Colors.Registration.red.color)
        } else if let dd = dropDown {
            shakeComponent(component: dd)
            dd.changeBorder(color: Colors.Registration.red.color)
        } else if let dp = datePicker {
            shakeComponent(component: dp)
            dp.changeBorder(color: Colors.Registration.red.color)
        }
    }
    
    private func acceptedData(textField: TextField? = nil, textView: TextView? = nil) {
        if let textField = textField {
            textField.changeTitleColors(topTitleColor: Colors.Registration.green.color, bottomTitleColor: Colors.Registration.green.color)
            textField.changeBorder(color: Colors.Registration.green.color)
            textField.buttonImage = Icons.TextFieldIcons.checkmark.image
            textField.changeButtonTint(color: Colors.Registration.green.color)
        } else if let textView = textView {
            textView.changeTopText(color: Colors.Registration.green.color)
            textView.changeBorder(color: Colors.Registration.green.color)
        }
    }
    
    private func checkData() -> Bool {
        if let text = surnameTextField.text, text.isNameOk() {
            acceptedData(textField: surnameTextField)
        } else {
            noDataIn(textField: surnameTextField)
            scrollView.setContentOffset(CGPoint(x: 0, y: centerView.frame.minY), animated: true)
            return false
        }
        if let text = nameTextField.text, text.isNameOk() {
            acceptedData(textField: nameTextField)
        } else {
            noDataIn(textField: nameTextField)
            scrollView.setContentOffset(CGPoint(x: 0, y: centerView.frame.minY), animated: true)
            return false
        }
        let color = Colors.Registration.green.color
        if let text = statusView.getText(), !text.isEmpty {
            statusView.changeBorder(color: color)
        } else {
            noDataIn(dropDown: statusView)
            scrollView.setContentOffset(CGPoint(x: 0, y: centerView.frame.minY), animated: true)
            return false
        }
        if let text = typeView.getText(), !text.isEmpty {
            typeView.changeBorder(color: color)
        } else {
            noDataIn(dropDown: typeView)
            scrollView.setContentOffset(CGPoint(x: 0, y: centerView.frame.minY), animated: true)
            return false
        }
        if let text = targetView.getText(), !text.isEmpty {
            sourceView.changeBorder(color: color)
        } else {
            noDataIn(dropDown: targetView)
            scrollView.setContentOffset(CGPoint(x: 0, y: centerView.frame.minY), animated: true)
            return false
        }
        if let text = sourceView.getText(), !text.isEmpty {
            sourceView.changeBorder(color: color)
        } else {
            noDataIn(dropDown: sourceView)
            scrollView.setContentOffset(CGPoint(x: 0, y: centerView.frame.minY), animated: true)
            return false
        }
        if let text = numberTextField.text, text.isTelephoneNumberOk() {
            acceptedData(textField: numberTextField)
        } else {
            noDataIn(textField: numberTextField)
            scrollView.setContentOffset(CGPoint(x: 0, y: centerView.frame.minY), animated: true)
            return false
        }
        return true
    }
    
    @objc private func saveTapped() {
        if checkData() {
            delegate?.didGetClient(data: getData())
        }
    }
    
    @objc private func cancelTapped() {
        delegate?.cancelTapped()
    }
    func getData() -> Data {
        guard
            let course = courseData.filter({$0.name == courseView.getText()}).first?.id,
            let status = statusData.filter({$0.name == statusView.getText()}).first?.id,
            let name = nameTextField.text,
            let occupation = typeData.filter({$0.name == typeView.getText()}).first?.id,
            let phoneNo = numberTextField.text,
            let surname = surnameTextField.text,
            let target = targetData.filter({$0.name == targetView.getText()}).first?.id,
            let utm = sourceData.filter({$0.name == sourceView.getText()}).first?.id
        else {return Data()}
        let object = ClientPostModel(
            course: course,
            description: commentTextView.getTextView().text,
            email: "",
            experience: experienceView.getSelectedText() == experienceView.firstText,
            laptop: laptopView.getSelectedText() == laptopView.firstText,
            leavingReason: nil,
            name: name,
            occupation: occupation,
            patronymic: fathernameTextField.text,
            phoneNo: phoneNo,
            prepayment: nil,
            status: status,
            surname: surname,
            target: target,
            timer: Date().getTomorrow().toJSONStr(),
            utm: utm
        )
        return object.toJSONData() ?? Data()
    }
}


extension NewRequestView {
    func set<T: Decodable>(data: [T], For: Datas) {
        switch For {
        case .status:
            if let data = data as? [StatusModel] {
                statusData = data
            }
        case .course:
            if let data = data as? [CourseModel] {
                courseData = data
            }
        case .source:
            if let data = data as? [UTMModel] {
                sourceData = data
            }
        case .type:
            if let data = data as? [OccupationModel] {
                typeData = data
            }
        case .target:
            if let data = data as? [TargetModel] {
                targetData = data
            }
        }
    }
}

extension NewRequestView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        setInitialBorderColors()
        let color = Colors.MainPage.purple.color
        switch textView {
        case commentTextView.getTextView():
            commentTextView.changeBorder(color: color)
        default:
            break
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        switch textView {
        case commentTextView.getTextView():
            break
        default:
            break
        }
    }
}

extension NewRequestView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setInitialBorderColors()
        let color = Colors.MainPage.purple.color
        switch textField {
        case surnameTextField:
            surnameTextField.changeBorder(color: color)
        case nameTextField:
            nameTextField.changeBorder(color: color)
        case fathernameTextField:
            fathernameTextField.changeBorder(color: color)
        case numberTextField:
            numberTextField.changeBorder(color: color)
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setInitialBorderColors()
        switch textField {
        case surnameTextField:
            nameTextField.becomeFirstResponder()
        case nameTextField:
            fathernameTextField.becomeFirstResponder()
        case fathernameTextField:
            numberTextField.becomeFirstResponder()
        case numberTextField:
            endEditing(true)
        default:
            break
        }
        return true
    }
}

extension NewRequestView: DropDownViewDelegate {
    func didSelectItem(dropDown: DropDownView, at: Int) {
        
    }
    
    func didBeginEditing(dropDown: DropDownView) {
        switch dropDown {
        case statusView, courseView, typeView:
            scrollView.setContentOffset(CGPoint(x: 0, y: dropDown.center.y), animated: true)
        case sourceView, targetView:
            scrollView.setContentOffset(CGPoint(x: 0, y: (dropDown.frame.height/2)+400), animated: true)
        default:
            break
        }
    }
    
    func didEndEditing(dropDown: DropDownView) {
        
    }
}
