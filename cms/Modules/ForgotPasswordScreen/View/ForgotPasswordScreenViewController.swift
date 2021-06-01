//
//  ForgotPasswordScreenViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 10/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class ForgotPasswordScreenViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var button: EnterButton!
    @IBOutlet weak var accountButton: LinkButton!
    
    var output: ForgotPasswordScreenViewOutput!
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    private func configureButtons() {
        button.addTarget(output, action: #selector(output.buttonTapped), for: .touchUpInside)
        accountButton.addTarget(output, action: #selector(output.accountHaveTapped), for: .touchUpInside)
    }
    
    private func configureTextField() {
        emailTextField.delegate = self
    }
    
    
    // MARK: - Set Components Colors
    
    private func setInitialStatesOfComponents() {
        let borderColor = Colors.Registration.borderColor.color
        let titleColor = Colors.Registration.labelColor.color
        configureComponent(component: emailTextField, borderColor: borderColor, titleColor: titleColor)
    }
    
    private func configureComponent(component: TextField, borderColor: UIColor, titleColor: UIColor) {
        component.changeTitleColors(topTitleColor: titleColor, bottomTitleColor: titleColor)
        component.changeBorder(color: borderColor)
        component.buttonImage = nil
        component.bottomTitleText = ""
    }
    
    private func noDataIn(component: TextField, text: String = "") {
        shakeComponent(component: component)
        component.changeTitleColors(topTitleColor: Colors.Registration.red.color, bottomTitleColor: Colors.Registration.red.color)
        component.changeBorder(color: Colors.Registration.red.color)
        component.setBottomTitle(text: text)
        component.buttonImage = Icons.TextFieldIcons.x.image
        component.changeButtonTint(color: Colors.Registration.red.color)
    }
    
    @objc private func dismissAlertView() {
        if let view = view.viewWithTag(111) {
            view.removeFromSuperview()
            output.nextPage()
        }
    }
}


// MARK: - View Input

extension ForgotPasswordScreenViewController: ForgotPasswordScreenViewInput {
    
    func invalidEmail() {
        view.endEditing(true)
        noDataIn(component: emailTextField, text: "Email введен не корректно")
    }
    
    func showAlert(message: String) {
        view.endEditing(true)
        let alert = AlertView(frame: view.bounds)
        alert.setTitle(text: "Ваш новый пароль отправлен почту: \(message)")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertView))
        alert.tag = 111
        alert.addGestureRecognizer(tap)
        view.addSubview(alert)
    }
    
    
    func getEmail() -> String? {
        return emailTextField.text
    }
    
    func setupInitialState() {
        configureButtons()
        configureTextField()
        view.dismissKeyboard()
    }
}


extension ForgotPasswordScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        emailTextField.changeBorder(color: Colors.Registration.labelColor.color)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setInitialStatesOfComponents()
        emailTextField.changeBorder(color: Colors.Registration.purple.color)
    }
}
