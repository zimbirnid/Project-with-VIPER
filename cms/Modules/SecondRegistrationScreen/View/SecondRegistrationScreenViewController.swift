//
//  SecondRegistrationScreenViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 05/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class SecondRegistrationScreenViewController: BaseViewController {

    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var numberTextField: TextField!
    @IBOutlet weak var cityView: ChoiceView!
    @IBOutlet weak var backButton: EnterButton!
    @IBOutlet weak var button: EnterButton!
    @IBOutlet weak var textFieldsView: UIView!
    
    var output: SecondRegistrationScreenViewOutput!


    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configureButtons() {
        button.addTarget(output, action: #selector(output.buttonTapped), for: .touchUpInside)
        backButton.addTarget(output, action: #selector(output.goBack), for: .touchUpInside)
    }
    
    
    // MARK: - Configure TextFields
    
    private func configureTextFields() {
        emailTextField.delegate = self
        numberTextField.delegate = self
        textFieldsView.dismissKeyboard()
    }
    
    
    // MARK: - Set Components Colors
    
    private func setInitialStatesOfComponents() {
        let borderColor = Colors.Registration.borderColor.color
        let titleColor = Colors.Registration.titleDarkGray.color
        configureComponent(component: emailTextField, borderColor: borderColor, titleColor: titleColor)
        configureComponent(component: numberTextField, borderColor: borderColor, titleColor: titleColor)
    }
    
    private func configureComponent(component: TextField, borderColor: UIColor, titleColor: UIColor) {
        component.changeTitleColors(topTitleColor: titleColor, bottomTitleColor: titleColor)
        component.changeBorder(color: borderColor)
        component.bottomTitleText = ""
        component.buttonImage = nil
    }
    
    
    private func noDataIn(component: TextField, text: String = "") {
        shakeComponent(component: component)
        component.changeTitleColors(topTitleColor: Colors.Registration.red.color, bottomTitleColor: Colors.Registration.red.color)
        component.changeBorder(color: Colors.Registration.red.color)
        component.bottomTitleText = text
        component.buttonImage = Icons.TextFieldIcons.x.image
        component.changeButtonTint(color: Colors.Registration.red.color)
    }
    
    private func acceptedData(component: TextField) {
        component.changeTitleColors(topTitleColor: Colors.Registration.green.color, bottomTitleColor: Colors.Registration.green.color)
        component.changeBorder(color: Colors.Registration.green.color)
        component.bottomTitleText = ""
        component.buttonImage = Icons.TextFieldIcons.checkmark.image
        component.changeButtonTint(color: Colors.Registration.green.color)
    }
}


// MARK: - View Input

extension SecondRegistrationScreenViewController: SecondRegistrationScreenViewInput {
    
    
    // MARK: - Return Data of Components
    
    func getData() -> (String?, String?, String) {
        return (emailTextField.text, numberTextField.text, cityView.getSelectedText())
    }
    
    
    // MARK: - Missing Data in Component
    
    func noData(In: Int) {
        setInitialStatesOfComponents()
        switch In {
        case 0:
            noDataIn(component: numberTextField, text: "Номер введен не корректно")
        case 1:
            acceptedData(component: numberTextField)
            noDataIn(component: emailTextField, text: "Email введен не корректно")
        default:
            break
        }
    }
    
    
    func setupInitialState() {
        configureButtons()
        configureTextFields()
    }
}


extension SecondRegistrationScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case numberTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
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
        case emailTextField:
            emailTextField.changeBorder(color: color)
        case numberTextField:
            numberTextField.changeBorder(color: color)
        default:
            break
        }
    }
}
