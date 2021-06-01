//
//  DetailsView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 3/4/21.
//

import UIKit

protocol ClientDetailsViewDelegate {
    func addPaymentTapped()
}

@IBDesignable
class ClientDetailsView: UIView {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
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
        view.backgroundColor = .clear
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
    
    private lazy var numberTextField: TextField = {
        let textfield = TextField()
        textfield.textContentType = .telephoneNumber
        textfield.keyboardType = .numberPad
        textfield.topTitleText = "Телефон:"
        textfield.cornerRadius = 4
        textfield.font = Fonts.GothamPro.regular.font(size: 16)
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
    
    private lazy var separatorTwo: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.MainPage.borderColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var statusView: DropDownView = {
        let view = DropDownView()
        view.topText = "Статус:"
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
    
    private lazy var exCoursesView: ExLanguageView = {
        let view = ExLanguageView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var typeView: DropDownView = {
        let view = DropDownView()
        view.topText = "Тип:"
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
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 12))
        view.changeLabel(font: Fonts.GothamPro.regular.font(size: 16))
        view.changeCellText(font: Fonts.GothamPro.regular.font(size: 14))
        view.leftPadding = 15
        view.leftLabelPadding = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separatorThree: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.MainPage.borderColor.color
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
        view.changeLabelBackground(color: Colors.MainCardDetail.buttonDropDown.color)
        view.isIconMoveEnabled = true
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
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 14))
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.topText = "Комментарий:"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sixthView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var monthView: DropDownView = {
        let view = DropDownView()
        view.delegate = self
        view.topText = "Месяц:"
        view.height = 30
        view.leftLabelPadding = 0
        view.set(data: ["Январь","Февраль","Март","Апрель","Июнь","Июль","Август","Сентябрь","Октябрь","Ноябрь","Декабрь"])
        view.leftPadding = 15
        view.changeBorder(color: Colors.MainPage.borderColor.color)
        view.changeBorder(width: 1)
        view.changeTopText(color: Colors.MainCardDetail.label.color)
        view.changeTopText(font: Fonts.GothamPro.medium.font(size: 12))
        view.changeLabel(font: Fonts.GothamPro.regular.font(size: 16))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var costTextField: TextField = {
        let textfield = TextField()
        textfield.topTitleText = "Стоимость:"
        textfield.cornerRadius = 4
        textfield.isEnabled = false
        textfield.font = Fonts.GothamPro.regular.font(size: 16)
        textfield.changeTitleColors(topTitleColor: Colors.MainCardDetail.label.color, bottomTitleColor: Colors.MainCardDetail.label.color)
        textfield.changeBorder(color: Colors.MainPage.borderColor.color)
        textfield.setRightIcon(image: Icons.ClientsPage.som.image)
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var paidTextField: TextField = {
        let textfield = TextField()
        textfield.topTitleText = "Оплатил:"
        textfield.cornerRadius = 4
        textfield.isEnabled = false
        textfield.font = Fonts.GothamPro.regular.font(size: 16)
        textfield.changeTitleColors(topTitleColor: Colors.MainCardDetail.label.color, bottomTitleColor: Colors.MainCardDetail.label.color)
        textfield.changeBorder(color: Colors.MainPage.borderColor.color)
        textfield.setRightIcon(image: Icons.ClientsPage.som.image)
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var debtTextField: TextField = {
        let textfield = TextField()
        textfield.topTitleText = "Долг:"
        textfield.cornerRadius = 4
        textfield.isEnabled = false
        textfield.setRightIcon(image: Icons.ClientsPage.som.image)
        textfield.font = Fonts.GothamPro.regular.font(size: 16)
        textfield.changeTitleColors(topTitleColor: Colors.MainCardDetail.label.color, bottomTitleColor: Colors.MainCardDetail.label.color)
        textfield.changeBorder(color: Colors.MainPage.borderColor.color)
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var methodTextField: TextField = {
        let textfield = TextField()
        textfield.topTitleText = "Метод:"
        textfield.cornerRadius = 4
        textfield.isEnabled = false
        textfield.font = Fonts.GothamPro.regular.font(size: 16)
        textfield.changeTitleColors(topTitleColor: Colors.MainCardDetail.label.color, bottomTitleColor: Colors.MainCardDetail.label.color)
        textfield.changeBorder(color: Colors.MainPage.borderColor.color)
        textfield.changeFont(font: Fonts.GothamPro.medium.font(size: 12), For: .top)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var addPaymentButton: EnterButton = {
        let button = EnterButton()
        button.cornerRadius = 4
        button.changeBackgroundColor(color: Colors.MainPage.purple.color)
        button.setTitle("Добавить платеж", for: .normal)
        button.titleLabel?.font = Fonts.GothamPro.medium.font(size: 14)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var scrollViewTopConstraint: NSLayoutConstraint = {
        NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: backgroundView, attribute: .top, multiplier: 1, constant: 0)
    }()
    
    enum Datas {
        case status
        case course
        case source
        case type
        case target
    }
    
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
    
    private var doesHaveExCourses = false
    var isStudent = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    private var client: ClientModel? {
        didSet {
            surnameTextField.text = client?.surname
            nameTextField.text = client?.name
            fathernameTextField.text = client?.patronymic
            numberTextField.text = client?.phoneNo?.toBestStyle()
            courseView.set(text: client?.course?.name)
            statusView.set(text: client?.status?.name)
            if let status = client?.status?.name, ["записался на курс", "запись на курс"].contains(status.lowercased()) {
                isStudent = true
            }
            typeView.set(text: client?.occupation?.name)
            experienceView.selectCircle(firstCircle: client?.experience ?? true)
            targetView.set(text: client?.target?.name)
            sourceView.set(text: client?.utm?.name)
            laptopView.selectCircle(firstCircle: client?.laptop ?? true)
            commentTextView.getTextView().text = client?.description
            
            checkPayments()
            setupExCoursesIfPresent()
        }
    }
    var delegate: ClientDetailsViewDelegate?
}


// MARK: - Private Functions

extension ClientDetailsView {
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
        firstView.addSubview(personalInfoLabel)
        firstView.addSubview(surnameTextField)
        firstView.addSubview(nameTextField)
        firstView.addSubview(fathernameTextField)
        firstView.addSubview(contactInfoLabel)
        firstView.addSubview(numberTextField)
        firstView.addSubview(separatorOne)
        
        centerView.addSubview(secondView)
        secondView.addSubview(statusView)
        secondView.addSubview(educationLabel)
        secondView.addSubview(courseView)
        if doesHaveExCourses {
            secondView.addSubview(exCoursesView)
        }
        secondView.addSubview(typeView)
        secondView.addSubview(experienceView)
        secondView.addSubview(separatorTwo)
        
        centerView.addSubview(thirdView)
        thirdView.addSubview(targetView)
        thirdView.addSubview(separatorThree)
        
        centerView.addSubview(fourthView)
        fourthView.addSubview(additionalInfoLabel)
        fourthView.addSubview(sourceView)
        fourthView.addSubview(laptopView)
        
        centerView.addSubview(fifthView)
        fifthView.addSubview(commentTextView)
        
        if isStudent {
            centerView.addSubview(sixthView)
            sixthView.addSubview(monthView)
            sixthView.addSubview(costTextField)
            sixthView.addSubview(paidTextField)
            sixthView.addSubview(debtTextField)
            sixthView.addSubview(methodTextField)
            sixthView.addSubview(addPaymentButton)
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
                fathernameTextField.heightAnchor.constraint(equalToConstant: 30),
                fathernameTextField.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
                
                separatorOne.topAnchor.constraint(equalTo: fathernameTextField.bottomAnchor, constant: 20),
                separatorOne.leadingAnchor.constraint(equalTo: fathernameTextField.leadingAnchor),
                separatorOne.trailingAnchor.constraint(equalTo: fathernameTextField.trailingAnchor),
                separatorOne.heightAnchor.constraint(equalToConstant: 1),

                contactInfoLabel.topAnchor.constraint(equalTo: separatorOne.bottomAnchor, constant: 20),
                contactInfoLabel.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 20),
                contactInfoLabel.heightAnchor.constraint(equalToConstant: 30),

                numberTextField.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 42),
                numberTextField.leadingAnchor.constraint(equalTo: contactInfoLabel.leadingAnchor),
                numberTextField.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -20),
                numberTextField.heightAnchor.constraint(equalToConstant: 30),
                numberTextField.bottomAnchor.constraint(equalTo: firstView.bottomAnchor),

                secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor),
                secondView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
                secondView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),

                statusView.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 42),
                statusView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20),
                statusView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -20),

                separatorTwo.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 20),
                separatorTwo.leadingAnchor.constraint(equalTo: statusView.leadingAnchor),
                separatorTwo.trailingAnchor.constraint(equalTo: statusView.trailingAnchor),
                separatorTwo.heightAnchor.constraint(equalToConstant: 1),
                
                educationLabel.topAnchor.constraint(equalTo: separatorTwo.bottomAnchor, constant: 20),
                educationLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20),
                educationLabel.heightAnchor.constraint(equalToConstant: 30),

                courseView.topAnchor.constraint(equalTo: educationLabel.bottomAnchor, constant: 42),
                courseView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20),
                courseView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -20),

                typeView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 22),
                typeView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -20),

                experienceView.topAnchor.constraint(equalTo: typeView.bottomAnchor, constant: 42),
                experienceView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20),
                experienceView.widthAnchor.constraint(equalToConstant: 200),
                experienceView.bottomAnchor.constraint(equalTo: secondView.bottomAnchor),


                thirdView.topAnchor.constraint(equalTo: secondView.bottomAnchor),
                thirdView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
                thirdView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),

                targetView.topAnchor.constraint(equalTo: thirdView.topAnchor, constant: 42),
                targetView.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 20),
                targetView.trailingAnchor.constraint(equalTo: thirdView.trailingAnchor, constant: -20),

                separatorThree.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 20),
                separatorThree.leadingAnchor.constraint(equalTo: targetView.leadingAnchor),
                separatorThree.trailingAnchor.constraint(equalTo: targetView.trailingAnchor),
                separatorThree.heightAnchor.constraint(equalToConstant: 1),
                targetView.bottomAnchor.constraint(equalTo: thirdView.bottomAnchor),
                
                fourthView.topAnchor.constraint(equalTo: thirdView.bottomAnchor),
                fourthView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
                fourthView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),

                additionalInfoLabel.topAnchor.constraint(equalTo: fourthView.topAnchor, constant: 20),
                additionalInfoLabel.leadingAnchor.constraint(equalTo: fourthView.leadingAnchor, constant: 20),
                additionalInfoLabel.heightAnchor.constraint(equalToConstant: 30),

                sourceView.topAnchor.constraint(equalTo: additionalInfoLabel.bottomAnchor, constant: 42),
                sourceView.leadingAnchor.constraint(equalTo: fourthView.leadingAnchor, constant: 20),
                sourceView.trailingAnchor.constraint(equalTo: fourthView.trailingAnchor, constant: -20),

                laptopView.topAnchor.constraint(equalTo: sourceView.bottomAnchor, constant: 42),
                laptopView.leadingAnchor.constraint(equalTo: fourthView.leadingAnchor, constant: 20),
                laptopView.widthAnchor.constraint(equalToConstant: 200),
                laptopView.bottomAnchor.constraint(equalTo: fourthView.bottomAnchor),

                fifthView.topAnchor.constraint(equalTo: fourthView.bottomAnchor),
                fifthView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
                fifthView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),

                commentTextView.topAnchor.constraint(equalTo: laptopView.bottomAnchor, constant: 42),
                commentTextView.leadingAnchor.constraint(equalTo: fifthView.leadingAnchor, constant: 20),
                commentTextView.trailingAnchor.constraint(equalTo: fifthView.trailingAnchor, constant: -20),
                commentTextView.bottomAnchor.constraint(equalTo: fifthView.bottomAnchor),
            ]
        )
        if doesHaveExCourses {
            NSLayoutConstraint.activate(
                [
                    exCoursesView.topAnchor.constraint(equalTo: courseView.bottomAnchor, constant: 18),
                    exCoursesView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor),
                    exCoursesView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor),
                    
                    typeView.topAnchor.constraint(equalTo: exCoursesView.bottomAnchor, constant: 42)
                ]
            )
        } else {
            typeView.topAnchor.constraint(equalTo: courseView.bottomAnchor, constant: 42).isActive = true
        }
        if isStudent {
            NSLayoutConstraint.activate(
                [
                    sixthView.topAnchor.constraint(equalTo: fifthView.bottomAnchor),
                    sixthView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),
                    sixthView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),

                    monthView.topAnchor.constraint(equalTo: sixthView.topAnchor, constant: 42),
                    monthView.leadingAnchor.constraint(equalTo: sixthView.leadingAnchor, constant: 20),
                    monthView.trailingAnchor.constraint(equalTo: sixthView.trailingAnchor, constant: -20),
                    
                    costTextField.topAnchor.constraint(equalTo: monthView.bottomAnchor, constant: 42),
                    costTextField.leadingAnchor.constraint(equalTo: sixthView.leadingAnchor, constant: 20),
                    costTextField.trailingAnchor.constraint(equalTo: sixthView.trailingAnchor, constant: -20),
                    costTextField.heightAnchor.constraint(equalToConstant: 30),

                    paidTextField.topAnchor.constraint(equalTo: costTextField.bottomAnchor, constant: 42),
                    paidTextField.leadingAnchor.constraint(equalTo: sixthView.leadingAnchor, constant: 20),
                    paidTextField.trailingAnchor.constraint(equalTo: sixthView.trailingAnchor, constant: -20),
                    paidTextField.heightAnchor.constraint(equalToConstant: 30),

                    debtTextField.topAnchor.constraint(equalTo: paidTextField.bottomAnchor, constant: 42),
                    debtTextField.leadingAnchor.constraint(equalTo: sixthView.leadingAnchor, constant: 20),
                    debtTextField.trailingAnchor.constraint(equalTo: sixthView.trailingAnchor, constant: -20),
                    debtTextField.heightAnchor.constraint(equalToConstant: 30),
                    
                    methodTextField.topAnchor.constraint(equalTo: debtTextField.bottomAnchor, constant: 42),
                    methodTextField.leadingAnchor.constraint(equalTo: sixthView.leadingAnchor, constant: 20),
                    methodTextField.trailingAnchor.constraint(equalTo: sixthView.trailingAnchor, constant: -20),
                    methodTextField.heightAnchor.constraint(equalToConstant: 30),


                    addPaymentButton.topAnchor.constraint(equalTo: methodTextField.bottomAnchor, constant: 20),
                    addPaymentButton.leadingAnchor.constraint(equalTo: debtTextField.leadingAnchor),
                    addPaymentButton.trailingAnchor.constraint(equalTo: debtTextField.trailingAnchor),
                    addPaymentButton.heightAnchor.constraint(equalToConstant: 36),
                    addPaymentButton.bottomAnchor.constraint(equalTo: sixthView.bottomAnchor, constant: -40),

                    sixthView.bottomAnchor.constraint(equalTo: centerView.bottomAnchor),
                ]
            )
        } else {
            fifthView.bottomAnchor.constraint(equalTo: centerView.bottomAnchor).isActive = true
        }
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
    
    private func setupExCoursesIfPresent() {
        guard
            let payments = client?.payments,
            !payments.isEmpty,
            let courseID = client?.course?.id
        else {return}
        let otherCourses = payments.filter({$0.id != courseID})
        guard !otherCourses.isEmpty else {return}
        var data = [String]()
        for i in otherCourses {
            guard let name = courseData.filter({$0.id == i.id}).last?.name else {return}
            data.append(name)
        }
        doesHaveExCourses = true
        exCoursesView.set(data: data)
        setNeedsLayout()
    }
    
    @objc private func buttonTapped() {
        delegate?.addPaymentTapped()
    }
    
    private func checkPayments() {
        if
            let p = client?.payments?.filter({$0.course?.name == client?.course?.name}),
            !p.isEmpty {
            costTextField.text = "\((client?.course?.price ?? 0) / p.count)"
            monthView.set(text: p.first?.month)
            paidTextField.text = "\(p.first?.price ?? 0)"
            methodTextField.text = "\(p.first?.method?.name ?? "")"
            var sum = (Int(costTextField.text ?? "0") ?? 0) - (Int(paidTextField.text ?? "0") ?? 0)
            sum = sum < 0 ? 0 : sum
            debtTextField.text = "\(sum)"
        } else {
            costTextField.text = "\(client?.course?.price ?? 0)"
            monthView.set(text: "Январь")
            paidTextField.text = "\(0)"
            debtTextField.text = costTextField.text
            methodTextField.text = ""
        }
    }
    
    private func configureLabels() {
        let p = client?.payments?.filter({
            $0.course?.id == client?.course?.id &&
            $0.month == monthView.getText()
        })
        paidTextField.text = "\(p?.last?.price ?? 0)"
        var sum = (Int(costTextField.text ?? "0") ?? 0) - (Int(paidTextField.text ?? "0") ?? 0)
        sum = sum < 0 ? 0 : sum
        debtTextField.text = "\(sum)"
        methodTextField.text = p?.last?.method?.name
    }
}


// MARK: - Public Functions

extension ClientDetailsView {
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
        statusView.changeBorder(color: color)
        typeView.changeBorder(color: color)
        courseView.changeBorder(color: color)
        sourceView.changeBorder(color: color)
        return true
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
            timer: nil,
            utm: utm
        )
        return object.toJSONData() ?? Data()
    }
    
    func set(client: ClientModel) {
        self.client = client
    }
    func getClientID() -> Int {
        return client!.clientID!
    }
    
    func didGet(sum: Int) {
//        let allSum = sum + Int(paidTextField.text!)!
//        paidTextField.text = "\(allSum)"
    }

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


// MARK: - UITextViewDelegate

extension ClientDetailsView: UITextViewDelegate {
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


// MARK: - UITextFieldDelegate

extension ClientDetailsView: UITextFieldDelegate {
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


// MARK: - DropDownViewDelegate

extension ClientDetailsView: DropDownViewDelegate {
    func didSelectItem(dropDown: DropDownView, at: Int) {
        configureLabels()
    }
    
    func didBeginEditing(dropDown: DropDownView) {}
    
    func didEndEditing(dropDown: DropDownView) {}
}
