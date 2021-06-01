//
//  WorkerDetailsView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 9/4/21.
//

import UIKit

@IBDesignable
class WorkerDetailsView: UIView {
    
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
        scroll.backgroundColor = .white
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
        textfield.font = Fonts.GothamPro.regular.font(size: 16)
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
        textfield.font = Fonts.GothamPro.regular.font(size: 16)
        textfield.changeBorder(color: Colors.MainPage.borderColor.color)
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var fathernameTextField: TextField = {
        let textfield = TextField()
        textfield.topTitleText = "Отчество:"
        textfield.cornerRadius = 4
        textfield.font = Fonts.GothamPro.regular.font(size: 16)
        textfield.changeTitleColors(topTitleColor: Colors.MainCardDetail.label.color, bottomTitleColor: Colors.MainCardDetail.label.color)
        textfield.changeBorder(color: Colors.MainPage.borderColor.color)
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var separatorOne: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.MainPage.borderColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        textfield.textContentType = .emailAddress
        textfield.keyboardType = .emailAddress
        textfield.topTitleText = "Email:"
        textfield.cornerRadius = 4
        textfield.font = Fonts.GothamPro.regular.font(size: 16)
        textfield.changeTitleColors(topTitleColor: Colors.MainCardDetail.label.color, bottomTitleColor: Colors.MainCardDetail.label.color)
        textfield.changeBorder(color: Colors.MainPage.borderColor.color)
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var numberTextField: TextField = {
        let textfield = TextField()
        textfield.textContentType = .telephoneNumber
        textfield.keyboardType = .phonePad
        textfield.topTitleText = "Телефон:"
        textfield.cornerRadius = 4
        textfield.font = Fonts.GothamPro.regular.font(size: 16)
        textfield.changeTitleColors(topTitleColor: Colors.MainCardDetail.label.color, bottomTitleColor: Colors.MainCardDetail.label.color)
        textfield.changeBorder(color: Colors.MainPage.borderColor.color)
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
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
    
    private lazy var secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separatorTwo: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.MainPage.borderColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var thirdView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var occupationView: DropDownView = {
        let view = DropDownView()
        view.topText = "Должность:"
        view.height = 30
        view.delegate = self
        view.isIconMoveEnabled = true
        view.changeLabelBackground(color: Colors.MainCardDetail.buttonDropDown.color)
        view.leftLabelPadding = 8
        view.leftPadding = 0
        view.changeBorder(color: .clear)
        view.changeBorder(width: 0)
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 12))
        view.changeLabel(font: Fonts.GothamPro.medium.font(size: 16))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var courseView: DropDownView = {
        let view = DropDownView()
        view.topText = "Курс:"
        view.height = 30
        view.isIconMoveEnabled = true
        view.changeLabelBackground(color: Colors.MainCardDetail.buttonDropDown.color)
        view.leftLabelPadding = 8
        view.leftPadding = 0
        view.changeBorder(color: .clear)
        view.changeBorder(width: 0)
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 12))
        view.changeLabel(font: Fonts.GothamPro.medium.font(size: 16))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var patentTextField: TextField = {
        let textfield = TextField()
        textfield.keyboardType = .numberPad
        textfield.topTitleText = "№ Патента:"
        textfield.cornerRadius = 4
        textfield.font = Fonts.GothamPro.regular.font(size: 16)
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
    
    private lazy var scrollViewTopConstraint: NSLayoutConstraint = {
        NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: backgroundView, attribute: .top, multiplier: 1, constant: 0)
    }()
    
    enum Datas {
        case occupation
        case course
    }
    
    private var occupationData = [PositionModel]() {
        didSet {
            let a = occupationData.map{$0.name!}
            occupationView.set(data: a)
        }
    }
    
    private var courseData = [CourseModel]() {
        didSet {
            let a = courseData.map{$0.name!}
            courseView.set(data: a)
        }
    }
    
    private var isMentor = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    private var worker: TeacherModel? {
        didSet {
            fathernameTextField.text = worker?.patronymic
            nameTextField.text = worker?.name
            surnameTextField.text = worker?.surname
            emailTextField.text = worker?.email
            numberTextField.text = worker?.phoneNo?.toBestStyle()
            occupationView.set(text: worker?.position)
            if worker?.position == "Ментор" || worker?.position?.lowercased() == "преподаватель" || worker?.position == "Teacher" {
                isMentor = true
                courseView.set(text: worker?.courseName)
                patentTextField.text = worker?.patent
                dateOpenedView.set(time: worker?.startDate)
                dateClosedView.set(time: worker?.endDate)
            } else {
                isMentor = false
            }
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
        backgroundColor = .white
    }
    
    private func setupSubviews() {
        addSubview(backgroundView)
        addSubview(scrollView)
        scrollView.addSubview(centerView)
        
        centerView.addSubview(firstView)
        firstView.addSubview(personalInfoLabel)
        firstView.addSubview(surnameTextField)
        firstView.addSubview(nameTextField)
        firstView.addSubview(fathernameTextField)
        firstView.addSubview(contactInfoLabel)
        firstView.addSubview(numberTextField)
        firstView.addSubview(separatorOne)
        firstView.addSubview(emailTextField)
        firstView.addSubview(additionalInfoLabel)
        firstView.addSubview(separatorTwo)
        
        centerView.addSubview(secondView)
        secondView.addSubview(occupationView)
        
        if isMentor {
            centerView.addSubview(thirdView)
            thirdView.addSubview(courseView)
            thirdView.addSubview(patentTextField)
            thirdView.addSubview(dateOpenedView)
            thirdView.addSubview(dateClosedView)
        } else {
            thirdView.removeFromSuperview()
            courseView.removeFromSuperview()
            patentTextField.removeFromSuperview()
            dateOpenedView.removeFromSuperview()
            dateClosedView.removeFromSuperview()
        }
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

                personalInfoLabel.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 20),
                personalInfoLabel.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 20),

                surnameTextField.topAnchor.constraint(equalTo: personalInfoLabel.bottomAnchor, constant: 42),
                surnameTextField.leadingAnchor.constraint(equalTo: personalInfoLabel.leadingAnchor),
                surnameTextField.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
                surnameTextField.heightAnchor.constraint(equalToConstant: 30),

                nameTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 42),
                nameTextField.leadingAnchor.constraint(equalTo: surnameTextField.leadingAnchor),
                nameTextField.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
                nameTextField.heightAnchor.constraint(equalToConstant: 30),

                fathernameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 42),
                fathernameTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
                fathernameTextField.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
                fathernameTextField.heightAnchor.constraint(equalToConstant: 30),
                
                separatorOne.topAnchor.constraint(equalTo: fathernameTextField.bottomAnchor, constant: 20),
                separatorOne.leadingAnchor.constraint(equalTo: fathernameTextField.leadingAnchor),
                separatorOne.trailingAnchor.constraint(equalTo: fathernameTextField.trailingAnchor),
                separatorOne.heightAnchor.constraint(equalToConstant: 1),

                contactInfoLabel.topAnchor.constraint(equalTo: separatorOne.bottomAnchor, constant: 20),
                contactInfoLabel.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 20),
                
                emailTextField.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 42),
                emailTextField.leadingAnchor.constraint(equalTo: contactInfoLabel.leadingAnchor),
                emailTextField.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
                emailTextField.heightAnchor.constraint(equalToConstant: 30),

                numberTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 42),
                numberTextField.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 20),
                numberTextField.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
                numberTextField.heightAnchor.constraint(equalToConstant: 30),
                
                separatorTwo.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 20),
                separatorTwo.leadingAnchor.constraint(equalTo: numberTextField.leadingAnchor),
                separatorTwo.trailingAnchor.constraint(equalTo: numberTextField.trailingAnchor),
                separatorTwo.heightAnchor.constraint(equalToConstant: 1),
                
                additionalInfoLabel.topAnchor.constraint(equalTo: separatorTwo.bottomAnchor, constant: 20),
                additionalInfoLabel.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 20),
                additionalInfoLabel.bottomAnchor.constraint(equalTo: firstView.bottomAnchor),
                
                secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor),
                secondView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
                secondView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),

                occupationView.topAnchor.constraint(equalTo: additionalInfoLabel.bottomAnchor, constant: 42),
                occupationView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20),
                occupationView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -20),
                occupationView.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -42),

            ]
        )
        if isMentor {
            secondView.bottomAnchor.constraint(equalTo: centerView.bottomAnchor).isActive = false
            NSLayoutConstraint.activate(
                [
                    thirdView.topAnchor.constraint(equalTo: secondView.bottomAnchor),
                    thirdView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor),
                    thirdView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor),
    
                    courseView.topAnchor.constraint(equalTo: thirdView.topAnchor),
                    courseView.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 20),
                    courseView.trailingAnchor.constraint(equalTo: thirdView.trailingAnchor, constant: -20),
    
                    patentTextField.topAnchor.constraint(equalTo: courseView.bottomAnchor, constant: 42),
                    patentTextField.leadingAnchor.constraint(equalTo: courseView.leadingAnchor),
                    patentTextField.trailingAnchor.constraint(equalTo: courseView.trailingAnchor),
                    patentTextField.heightAnchor.constraint(equalToConstant: 30),
    
                    dateOpenedView.topAnchor.constraint(equalTo: patentTextField.bottomAnchor, constant: 42),
                    dateOpenedView.leadingAnchor.constraint(equalTo: courseView.leadingAnchor),
                    dateOpenedView.trailingAnchor.constraint(equalTo: courseView.trailingAnchor),
    
                    dateClosedView.topAnchor.constraint(equalTo: dateOpenedView.bottomAnchor, constant: 42),
                    dateClosedView.leadingAnchor.constraint(equalTo: courseView.leadingAnchor),
                    dateClosedView.trailingAnchor.constraint(equalTo: courseView.trailingAnchor),
                    dateClosedView.bottomAnchor.constraint(equalTo: thirdView.bottomAnchor, constant: -50),
                    thirdView.bottomAnchor.constraint(equalTo: centerView.bottomAnchor),
                ]
            )
        } else {
            secondView.bottomAnchor.constraint(equalTo: centerView.bottomAnchor).isActive = true
        }
    }
    
    private func configureTextfields() {
        surnameTextField.delegate = self
        nameTextField.delegate = self
        fathernameTextField.delegate = self
        emailTextField.delegate = self
        numberTextField.delegate = self
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
    }
    
    private func noDataIn(textField: TextField? = nil, textView: TextView? = nil) {
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
    
    func isDataOk() -> Bool {
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
        if let text = numberTextField.text, text.isTelephoneNumberOk() {
            acceptedData(textField: numberTextField)
        } else {
            noDataIn(textField: numberTextField)
            scrollView.setContentOffset(CGPoint(x: 0, y: centerView.frame.minY), animated: true)
            return false
        }
        let color = Colors.Registration.green.color
        occupationView.changeBorder(color: color)
        if isMentor {
            courseView.changeBorder(color: color)
            if let text = patentTextField.text, !text.isEmpty {
                acceptedData(textField: numberTextField)
            } else {
                noDataIn(textField: patentTextField)
                return false
            }
            dateOpenedView.changeBorder(color: color)
            dateClosedView.changeBorder(color: color)
        }
        return true
    }
    
    func getData() -> Data {
        guard
            let surname = surnameTextField.text,
            let name = nameTextField.text,
            let fathername = fathernameTextField.text,
            let email = emailTextField.text,
            let phoneNo = numberTextField.text,
            let occupation = occupationData.filter({$0.name == occupationView.getText()}).first?.id
            else {return Data()}
        let object =
            TeacherPostModel(
                course: isMentor ? courseData.filter({$0.name == courseView.getText()}).first?.id : nil,
                description: nil,
                email: email,
                endDate: isMentor ? dateClosedView.getJSONDate() : nil,
                name: name,
                patent: isMentor ? patentTextField.text : nil,
                patronymic: fathername,
                phoneNo: phoneNo,
                position: occupation,
                startDate: isMentor ? dateOpenedView.getJSONDate() : nil,
                surname: surname
            )
        return object.toJSONData() ?? Data()
    }
    
    func set(worker: TeacherModel) {
        self.worker = worker
    }
    func getWorkerID() -> Int {
        return worker!.workerID!
    }
}

extension WorkerDetailsView {
    func set<T: Decodable>(data: [T], For: Datas) {
        switch For {
        case .course:
            if let data = data as? [CourseModel] {
                courseData = data
            }
        case .occupation:
            if let data = data as? [PositionModel] {
                occupationData = data
            }
        }
    }
}

extension WorkerDetailsView: UITextFieldDelegate {
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


extension WorkerDetailsView: DropDownViewDelegate {
    func didSelectItem(dropDown: DropDownView, at: Int) {
//        if dropDown == occupationView {
//            let name = occupationData[at].name
//            if name  == "Ментор" || name == "преподаватель" || name == "Teacher" {
//                isMentor = true
//            } else {
//                isMentor = false
//            }
//        }
    }
    
    func didBeginEditing(dropDown: DropDownView) {}
    
    func didEndEditing(dropDown: DropDownView) {}
}
