//
//  RestorePasswordScreenViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 10/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class RestorePasswordScreenViewController: BaseViewController {

    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var againPasswordTextField: TextField!
    @IBOutlet weak var button: EnterButton!
    @IBOutlet weak var accountButton: LinkButton!
    @IBOutlet weak var textFieldsView: UIView!
    
    var output: RestorePasswordScreenViewOutput!


    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    
    private func configureButtons() {
        button.addTarget(output, action: #selector(output.buttonTapped), for: .touchUpInside)
        accountButton.addTarget(output, action: #selector(output.haveAccountTapped), for: .touchUpInside)
    }
    
    private func configureTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        againPasswordTextField.delegate = self
        textFieldsView.dismissKeyboard()
    }
    
    // MARK: - Set Components Colors
    
    private func setInitialStatesOfComponents() {
        let borderColor = Colors.Registration.borderColor.color
        let titleColor = Colors.Registration.labelColor.color
        configureComponent(component: emailTextField, borderColor: borderColor, titleColor: titleColor)
        configureComponent(component: passwordTextField, borderColor: borderColor, titleColor: titleColor)
        configureComponent(component: againPasswordTextField, borderColor: borderColor, titleColor: titleColor)
    }
    
    private func configureComponent(component: TextField, borderColor: UIColor, titleColor: UIColor) {
        component.changeTitleColors(topTitleColor: titleColor, bottomTitleColor: titleColor)
        component.changeBorder(color: borderColor)
        component.bottomTitleText = ""
    }
    
    
    private func noDataIn(component: TextField, text: String = "") {
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
    
    
    @objc private func dismissAlertView() {
        if let view = view.viewWithTag(111) {
            view.removeFromSuperview()
            output.haveAccountTapped()
        }
    }
}


// MARK: - View Input

extension RestorePasswordScreenViewController: RestorePasswordScreenViewInput {
    
    func getData() -> (String?, String?, String?) {
        return (emailTextField.text, passwordTextField.text, againPasswordTextField.text)
    }
    
    func noData(In: Int) {
        setInitialStatesOfComponents()
        textFieldsView.endEditing(true)
        switch In {
        case 0:
            noDataIn(component: emailTextField)
        case 1:
            acceptedData(component: emailTextField)
            noDataIn(component: passwordTextField, text: "Пароль должен содержать не менее 8 символов")
        case 2:
            acceptedData(component: emailTextField)
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


extension RestorePasswordScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setInitialStatesOfComponents()
        
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
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
        setInitialStatesOfComponents()
        let color = Colors.Registration.purple.color
        switch textField {
        case emailTextField:
            emailTextField.changeBorder(color: color)
        case passwordTextField:
            passwordTextField.changeBorder(color: color)
        case againPasswordTextField:
            againPasswordTextField.changeBorder(color: color)
        default:
            break
        }
    }
}
