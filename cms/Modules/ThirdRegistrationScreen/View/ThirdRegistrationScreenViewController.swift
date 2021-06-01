//
//  ThirdRegistrationScreenViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 09/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class ThirdRegistrationScreenViewController: BaseViewController {

    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var againPasswordTextField: TextField!
    @IBOutlet weak var backButton: EnterButton!
    @IBOutlet weak var nextButton: EnterButton!
    @IBOutlet weak var textFieldsView: UIView!
    private lazy var alertView: AlertView = {
        let view = AlertView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var output: ThirdRegistrationScreenViewOutput!


    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    private func configureButtons() {
        backButton.addTarget(output, action: #selector(output.backTapped), for: .touchUpInside)
        nextButton.addTarget(output, action: #selector(output.buttonTapped), for: .touchUpInside)
    }
    
    private func configureTextFields() {
        passwordTextField.delegate = self
        againPasswordTextField.delegate = self
        textFieldsView.dismissKeyboard()
    }
    
    // MARK: - Set Components Colors
    
    private func setInitialStatesOfComponents() {
        let borderColor = Colors.Registration.borderColor.color
        let titleColor = Colors.Registration.labelColor.color
        configureComponent(component: passwordTextField, borderColor: borderColor, titleColor: titleColor)
        configureComponent(component: againPasswordTextField, borderColor: borderColor, titleColor: titleColor)
    }
    
    private func configureComponent(component: TextField, borderColor: UIColor, titleColor: UIColor) {
        component.changeTitleColors(topTitleColor: titleColor, bottomTitleColor: titleColor)
        component.changeBorder(color: borderColor)
    }
    
    
    private func noDataIn(component: TextField, text: String = "") {
        shakeComponent(component: component)
        component.changeTitleColors(topTitleColor: Colors.Registration.red.color, bottomTitleColor: Colors.Registration.red.color)
        component.changeBorder(color: Colors.Registration.red.color)
        component.setBottomTitle(text: text)
    }
    
    private func acceptedData(component: TextField) {
        component.changeTitleColors(topTitleColor: Colors.Registration.green.color, bottomTitleColor: Colors.Registration.green.color)
        component.changeBorder(color: Colors.Registration.green.color)
    }
}


// MARK: - View Input

extension ThirdRegistrationScreenViewController: ThirdRegistrationScreenViewInput {
    func didGetSuccess() {
        view.addSubview(alertView)
        alertView.setTitle(text: "Ваш запрос на регистрацию отправлен к администратору на сайт")
        alertView.set(icon: Icons.Alert.alertImage.image)
        NSLayoutConstraint.activate(
            [
                alertView.topAnchor.constraint(equalTo: view.topAnchor),
                alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
        )
    }
    
    func didGetFail(message: String) {
        view.addSubview(alertView)
        alertView.setTitle(text: message)
        alertView.set(icon: Icons.Alert.failure.image)
        NSLayoutConstraint.activate(
            [
                alertView.topAnchor.constraint(equalTo: view.topAnchor),
                alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
        )
    }

    // MARK: - Return Data of Components
    
    func getData() -> (String?, String?) {
        return (passwordTextField.text, againPasswordTextField.text)
    }
    
    
    // MARK: - Missing Data in Component
    
    func noData(In: Int) {
        setInitialStatesOfComponents()
        switch In {
        case 0:
            noDataIn(component: passwordTextField)
        case 1:
            acceptedData(component: passwordTextField)
            noDataIn(component: againPasswordTextField, text: "Пароли не совпадают")
        default:
            break
        }
    }
    
    func setupInitialState() {
        configureButtons()
        configureTextFields()
    }
}


extension ThirdRegistrationScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case passwordTextField:
            againPasswordTextField.becomeFirstResponder()
        case againPasswordTextField:
            view.endEditing(true)
        default:
            break
        }
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let color = Colors.Registration.purple.color
        setInitialStatesOfComponents()
        switch textField {
        case passwordTextField:
            passwordTextField.changeBorder(color: color)
        case againPasswordTextField:
            againPasswordTextField.changeBorder(color: color)
        default:
            break
        }
    }
}

extension ThirdRegistrationScreenViewController: AlertViewDelegate {
    func didSelfRemoved() {
        output.popToHead()
    }
}
