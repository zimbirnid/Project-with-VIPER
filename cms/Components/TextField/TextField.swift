//
//  TextField.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 3/3/21.
//

import Foundation
import UIKit

@IBDesignable
class TextField: UITextField {
    
    
    // MARK: - ENUM
    
    private enum EyeState {
        case closed
        case shown
    }
    
    private enum Buttons {
        case eye
        case eyeSlash
        case x
        case checkmark
        case dropdown
        
        var value: UIImage? {
            switch self {
            case .eye:
                return Icons.TextFieldIcons.eye.image
            case .eyeSlash:
                return Icons.TextFieldIcons.eyeSlash.image
            case .x:
                return Icons.TextFieldIcons.x.image
            case .checkmark:
                return Icons.TextFieldIcons.checkmark.image
            case .dropdown:
                return Icons.TextFieldIcons.dropdown.image
            }
        }
    }
    
    enum Labels {
        case top
        case normal
        case bottom
    }
    
    
    // MARK: - Private vars
    
    private var currentEyeState: EyeState = .closed
    
    private lazy var topTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.GothamPro.regular.font(size: 17)
        label.textColor = Colors.Registration.textDarkGray.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.GothamPro.regular.font(size: 12)
        label.textColor = Colors.Registration.textDarkGray.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.tintColor = Colors.Registration.iconDarkGray.color
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var leftPadding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    
    
    // MARK: - IBInspectable vars
    
    @IBInspectable var topTitleText: String = "" {
        didSet {
            topTitleLabel.text = topTitleText
        }
    }
    
    @IBInspectable var bottomTitleText: String = "" {
        didSet {
            bottomTitleLabel.text = bottomTitleText
        }
    }
    
    @IBInspectable var buttonImage: UIImage? {
        didSet {
            button.setImage(buttonImage, for: .normal)
            if compareImages(one: button.imageView?.image, two: Buttons.eye.value)
                || compareImages(one: button.imageView?.image, two: Buttons.eyeSlash.value) {
                button.addTarget(self, action: #selector(imageButtonDidTap), for: .touchUpInside)
                isSecureTextEntry = true
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            configureBorders()
        }
    }
    
    @IBInspectable var leftTextPadding: CGFloat = 0 {
        didSet {
            leftPadding.left = leftTextPadding
            setNeedsLayout()
        }
    }
    
    override var textContentType: UITextContentType! {
        didSet {
            if textContentType == .telephoneNumber {
                keyboardType = .numberPad
                addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
                text = "+996 "
            }
        }
    }

    
    // MARK: - INITS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: leftPadding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: leftPadding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: leftPadding)
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        autocorrectionType = .no
        clearButtonMode = .never
        borderStyle = .roundedRect
        setupSubviews()
        setupConstraints()
        configureColors()
        changeTitleColors(topTitleColor: Colors.Registration.titleDarkGray.color, bottomTitleColor: Colors.Registration.titleDarkGray.color)
    }
    
    
    // MARK: - Change text to a specific format when typing
    
    @objc private func textFieldDidChange() {
        let result = formatPhoneNumber(number: text!)
        text = result
    }
    
    private func setupSubviews() {
        addSubview(topTitleLabel)
        addSubview(bottomTitleLabel)
        addSubview(button)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                topTitleLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: -15),
                topTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                
                bottomTitleLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 10),
                bottomTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                
                button.topAnchor.constraint(equalTo: topAnchor),
                button.trailingAnchor.constraint(equalTo: trailingAnchor),
                button.bottomAnchor.constraint(equalTo: bottomAnchor),
                button.widthAnchor.constraint(equalTo: heightAnchor),
            ]
        )
    }
    
    // MARK: - Configure Colors
    
    private func configureColors() {
        layer.borderColor = Colors.Registration.borderColor.color.cgColor
        textColor = .black
        backgroundColor = .white
    }
    
    
    // MARK: - Configure Borders
    
    private func configureBorders() {
        layer.cornerRadius = cornerRadius
        borderStyle = .none
        layer.borderWidth = 1
    }
    
    
    // MARK: - Change Border Color
    
    func changeBorder(color: UIColor) {
        layer.borderColor = color.cgColor
    }
    
    
    func changeButtonTint(color: UIColor) {
        button.tintColor = color
    }
    
    
    // MARK: - Change Title Color
    
    func changeTitleColors(topTitleColor: UIColor, bottomTitleColor: UIColor) {
        topTitleLabel.textColor = topTitleColor
        bottomTitleLabel.textColor = bottomTitleColor
    }
    
    
    // MARK: - Set Bottom Title Text
    
    func setBottomTitle(text: String) {
        bottomTitleText = text
    }
    
    
    func changeFont(font: UIFont, For: Labels) {
        switch For {
        case .top:
            topTitleLabel.font = font
        case .normal:
            self.font = font
        case .bottom:
            bottomTitleLabel.font = font
        }
    }
    
    
    // MARK: - set Place holder Color
    
    private func changePlaceholderColor(color: UIColor, forText: String) {
        attributedPlaceholder = NSAttributedString(string: forText, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    
    // MARK: - Eye Button action
    
    @objc private func imageButtonDidTap() {
        switch currentEyeState {
        case .closed:
            buttonImage = Buttons.eye.value
            isSecureTextEntry = false
            currentEyeState = .shown
        case .shown:
            buttonImage = Buttons.eyeSlash.value
            isSecureTextEntry = true
            currentEyeState = .closed
        }
    }
    
    
    // MARK: - Formatting phone number
    
    private func formatPhoneNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "+XXX (XXX) XX XX XX"
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for charac in mask where index < cleanPhoneNumber.endIndex {
            if charac == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(charac)
            }
        }
        return result.count < 5 ? "+996 " : result
    }
    
    func setRightIcon(image: UIImage?) {
        buttonImage = image
    }
}
