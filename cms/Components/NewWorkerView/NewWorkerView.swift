//
//  NewWorkerView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 1/4/21.
//

import UIKit

protocol NewWorkerViewDelegate {
    func didGetWorker(data: Data)
    func cancelTapped()
}

@IBDesignable
class NewWorkerView: UIView {
    
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
        label.text = "Новый сотрудник"
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
    
    private lazy var emailTextField: TextField = {
        let textfield = TextField()
        textfield.topTitleText = "Email:"
        textfield.cornerRadius = 4
        textfield.textContentType = .emailAddress
        textfield.keyboardType = .emailAddress
        textfield.font = Fonts.GothamPro.regular.font(size: 14)
        textfield.changeTitleColors(topTitleColor: Colors.MainCardDetail.label.color, bottomTitleColor: Colors.MainCardDetail.label.color)
        textfield.changeBorder(color: Colors.MainPage.borderColor.color)
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
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
    
    private lazy var otherLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.GothamPro.medium.font(size: 14)
        label.text = "Другое:"
        label.textAlignment = .center
        label.sizeToFit()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var occupationView: DropDownView = {
        let view = DropDownView()
        view.topText = "Должность:"
        view.height = 30
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 12))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var courseView: DropDownView = {
        let view = DropDownView()
        view.topText = "Курс:"
        view.height = 30
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 12))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var thirdView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.dismissKeyboard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var patentTextField: TextField = {
        let textfield = TextField()
        textfield.keyboardType = .numberPad
        textfield.topTitleText = "№ Патента:"
        textfield.cornerRadius = 4
        textfield.font = Fonts.GothamPro.regular.font(size: 14)
        textfield.changeTitleColors(topTitleColor: Colors.MainCardDetail.label.color, bottomTitleColor: Colors.MainCardDetail.label.color)
        textfield.changeBorder(color: Colors.MainPage.borderColor.color)
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var dateOpenedView: DatePickerView = {
        let datePicker = DatePickerView()
        datePicker.topTitle(text: "Дата открытия:")
        datePicker.changeBorder(color: Colors.MainPage.borderColor.color)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private lazy var dateClosedView: DatePickerView = {
        let datePicker = DatePickerView()
        datePicker.topTitle(text: "Дата закрытия:")
        datePicker.changeBorder(color: Colors.MainPage.borderColor.color)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
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
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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
        let const = NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        return const
    }()
    
    var delegate: NewWorkerViewDelegate?
    
    enum Datas {
        case occupation
        case course
    }
    
    private var courseData = [CourseModel]() {
        didSet {
            let a = courseData.map {$0.name!}
            courseView.set(data: a)
        }
    }
    
    private var occupationData = [PositionModel]() {
        didSet {
            let a = occupationData.filter({
                $0.name?.lowercased() == "ментор" ||
                $0.name?.lowercased() == "преподаватель"
            }).map {$0.name!}
            occupationView.set(data: a)
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
        firstView.addSubview(emailTextField)
        firstView.addSubview(numberTextField)
        firstView.addSubview(otherLabel)
        
        centerView.addSubview(secondView)
        
        secondView.addSubview(occupationView)
        secondView.addSubview(courseView)
        
        centerView.addSubview(thirdView)
        
        thirdView.addSubview(patentTextField)
        thirdView.addSubview(dateOpenedView)
        thirdView.addSubview(dateClosedView)
        thirdView.addSubview(commentTextView)
        thirdView.addSubview(cancelButton)
        thirdView.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                backgroundView.topAnchor.constraint(equalTo: topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                scrollViewTopConstraint,
                scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
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

                emailTextField.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 40),
                emailTextField.leadingAnchor.constraint(equalTo: contactInfoLabel.leadingAnchor),
                emailTextField.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
                emailTextField.heightAnchor.constraint(equalToConstant: 30),

                numberTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
                numberTextField.leadingAnchor.constraint(equalTo: contactInfoLabel.leadingAnchor),
                numberTextField.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
                numberTextField.heightAnchor.constraint(equalToConstant: 30),

                otherLabel.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 25),
                otherLabel.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 20),
                otherLabel.heightAnchor.constraint(equalToConstant: 30),
                otherLabel.bottomAnchor.constraint(equalTo: firstView.bottomAnchor, constant: -40),

                secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor),
                secondView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
                secondView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),

                occupationView.topAnchor.constraint(equalTo: secondView.topAnchor),
                occupationView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20),
                occupationView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -20),

                courseView.topAnchor.constraint(equalTo: occupationView.bottomAnchor, constant: 40),
                courseView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20),
                courseView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -20),
                courseView.bottomAnchor.constraint(equalTo: secondView.bottomAnchor),

                thirdView.topAnchor.constraint(equalTo: secondView.bottomAnchor),
                thirdView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
                thirdView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),

                patentTextField.topAnchor.constraint(equalTo: thirdView.topAnchor, constant: 40),
                patentTextField.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 20),
                patentTextField.trailingAnchor.constraint(equalTo: thirdView.trailingAnchor, constant: -20),
                patentTextField.heightAnchor.constraint(equalToConstant: 30),

                dateOpenedView.topAnchor.constraint(equalTo: patentTextField.bottomAnchor, constant: 40),
                dateOpenedView.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 20),
                dateOpenedView.trailingAnchor.constraint(equalTo: thirdView.trailingAnchor, constant: -20),

                dateClosedView.topAnchor.constraint(equalTo: dateOpenedView.bottomAnchor, constant: 40),
                dateClosedView.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 20),
                dateClosedView.trailingAnchor.constraint(equalTo: thirdView.trailingAnchor, constant: -20),

                commentTextView.topAnchor.constraint(equalTo: dateClosedView.bottomAnchor, constant: 40),
                commentTextView.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 20),
                commentTextView.trailingAnchor.constraint(equalTo: thirdView.trailingAnchor, constant: -20),

                saveButton.topAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: 20),
                saveButton.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 20),
                saveButton.trailingAnchor.constraint(equalTo: thirdView.trailingAnchor, constant: -20),
                saveButton.heightAnchor.constraint(equalToConstant: 36),
                
                cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
                cancelButton.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 20),
                cancelButton.trailingAnchor.constraint(equalTo: thirdView.trailingAnchor, constant: -20),
                cancelButton.heightAnchor.constraint(equalToConstant: 36),

                cancelButton.bottomAnchor.constraint(equalTo: thirdView.bottomAnchor, constant: -100),
                thirdView.bottomAnchor.constraint(equalTo: centerView.bottomAnchor),
            ]
        )
    }
    
    private func configureTextfields() {
        surnameTextField.delegate = self
        nameTextField.delegate = self
        fathernameTextField.delegate = self
        emailTextField.delegate = self
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
        occupationView.changeBorder(color: color)
        courseView.changeBorder(color: color)
        dateOpenedView.changeBorder(color: color)
        dateClosedView.changeBorder(color: color)
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
        let color = Colors.Registration.green.color
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
        if let text = emailTextField.text, text.isEmailOk() {
            acceptedData(textField: emailTextField)
        } else {
            noDataIn(textField: emailTextField)
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
        if let text = occupationView.getText(), !text.isEmpty {
            occupationView.changeBorder(color: color)
        } else {
            noDataIn(dropDown: occupationView)
            scrollView.setContentOffset(CGPoint(x: 0, y: centerView.frame.minY), animated: true)
            return false
        }
        dateOpenedView.changeBorder(color: color)
        dateClosedView.changeBorder(color: color)
        return true
    }
    
    @objc private func buttonTapped() {
        if checkData() {
            delegate?.didGetWorker(data: getData())
        }
    }
    
    @objc private func cancelTapped() {
        delegate?.cancelTapped()
    }
    
    func getData() -> Data {
        guard
            let name = nameTextField.text,
            let surname = surnameTextField.text,
            let patent = patentTextField.text,
            let phoneNo = numberTextField.text,
            let email = emailTextField.text,
            let occupation = occupationData.filter({$0.name?.lowercased() == occupationView.getText()?.lowercased()}).first?.id
            else {return Data()}
        let course = courseData.filter({$0.name == courseView.getText()}).first?.id
        let object = TeacherPostModel(
            course: course,
            description: commentTextView.getTextView().text,
            email: email,
            endDate: dateClosedView.getJSONDate(),
            name: name,
            patent: patent,
            patronymic: fathernameTextField.text,
            phoneNo: phoneNo,
            position: occupation,
            startDate: dateOpenedView.getJSONDate(),
            surname: surname
        )
        return object.toJSONData() ?? Data()
    }
}


extension NewWorkerView {
    func set<T: Decodable>(data: [T], For: Datas) {
        switch For {
        case .occupation:
            if let data = data as? [PositionModel] {
                occupationData = data
            }
        case .course:
            if let data = data as? [CourseModel] {
                courseData = data
            }
        }
    }
}

extension NewWorkerView: UITextViewDelegate {
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
}

extension NewWorkerView: UITextFieldDelegate {
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
        case emailTextField:
            emailTextField.changeBorder(color: color)
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
            emailTextField.becomeFirstResponder()
        case emailTextField:
            numberTextField.becomeFirstResponder()
        case numberTextField:
            endEditing(true)
        default:
            break
        }
        return true
    }
}
