//
//  AuthenticationOneAuthenticationOneViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 02/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class AuthenticationOneViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var enterButton: EnterButton!
    @IBOutlet weak var forgetButton: LinkButton!
    @IBOutlet weak var registerButton: LinkButton!
    
    var output: AuthenticationOneViewOutput!
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    private func configureButtons() {
        enterButton.addTarget(self, action: #selector(didTapEnter), for: .touchUpInside)
        forgetButton.addTarget(self, action: #selector(didTapForget), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    
    private func configureTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    // MARK: - Set Components Colors
    
    private func configureComponent(component: TextField, borderColor: UIColor, titleColor: UIColor) {
        component.changeTitleColors(topTitleColor: titleColor, bottomTitleColor: titleColor)
        component.changeBorder(color: borderColor)
    }
    
    private func noDataIn(component: TextField, text: String = "Введите корректные данные") {
        shakeComponent(component: component)
        component.changeTitleColors(topTitleColor: Colors.Registration.red.color, bottomTitleColor: Colors.Registration.red.color)
        component.changeBorder(color: Colors.Registration.red.color)
        component.bottomTitleText = text
    }
    
    private func acceptedData(component: TextField) {
        component.changeTitleColors(topTitleColor: Colors.Registration.green.color, bottomTitleColor: Colors.Registration.green.color)
        component.changeBorder(color: Colors.Registration.green.color)
        component.bottomTitleText = ""
    }
    
    @objc private func didTapEnter() {
        output.didTapEnter()
        addSpinnerForRequest()
    }
    
    @objc private func didTapForget() {
        output.didTapForget()
    }
    
    @objc private func didTapRegisterButton() {
        output.didTapRegisterButton()
    }
    
    private func addSpinnerForRequest() {
        view.addSubview(activityView)
        NSLayoutConstraint.activate(
            [
                activityView.topAnchor.constraint(equalTo: view.topAnchor),
                activityView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                activityView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                activityView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
        )
    }

    private func removeSpinner() {
        activityView.removeThisView()
    }
}


// MARK: - View Input

extension AuthenticationOneViewController: AuthenticationOneViewInput {
    
    func dataChecked(isOk: Bool, textFieldNumber: Int) {
        removeSpinner()
        switch textFieldNumber {
        case 0:
            if isOk {
                acceptedData(component: emailTextField)
            } else {
                noDataIn(component: emailTextField, text: "Email введен не корректно")
            }
        case 1:
            if isOk {
                acceptedData(component: passwordTextField)
            } else {
                noDataIn(component: passwordTextField, text: "Пароль должен содержать не менее 8 символов")
            }
        default:
            break
        }
    }
    
    func invalidData() {
        view.endEditing(true)
        noDataIn(component: emailTextField)
        noDataIn(component: passwordTextField)
        removeSpinner()
    }
    
    func validData() {
        removeSpinner()
    }
    
    func getData() -> (String?, String?) {
        return (emailTextField.text, passwordTextField.text)
    }

    func setupInitialState() {
        configureButtons()
        configureTextFields()
        view.dismissKeyboard()
    }
}


extension AuthenticationOneViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            view.endEditing(true)
        default:
            break
        }
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let color = Colors.Registration.purple.color
        switch textField {
        case emailTextField:
            configureComponent(component: emailTextField, borderColor: color, titleColor: Colors.Registration.titleDarkGray.color)
        case passwordTextField:
            configureComponent(component: passwordTextField, borderColor: color, titleColor: Colors.Registration.titleDarkGray.color)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            output.checkData(text: emailTextField.text, textFieldNumber: 0)
        case passwordTextField:
            output.checkData(text: passwordTextField.text, textFieldNumber: 1)
        default:
            break
        }
    }
}
