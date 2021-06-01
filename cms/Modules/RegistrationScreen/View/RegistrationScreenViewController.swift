//
//  RegistrationScreenViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 04/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class RegistrationScreenViewController: BaseViewController {

    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var tbView: UIView!
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var surnameTextField: TextField!
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var fatherNameTextField: TextField!
    @IBOutlet weak var occupationView: DropDownView!
    @IBOutlet weak var button: EnterButton!
    
    var output: RegistrationScreenViewOutput!
    
    
    // MARK: - Private vars
    
    private var tableViewState: TableViewState = .hidden
    
    
    // MARK: - ENUM
    
    private enum TableViewState {
        case hidden
        case shown
    }

    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    
    // MARK: - Configure Button
    
    private func configureButton() {
        button.addTarget(output, action: #selector(output.buttonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - Configure Views
    
    private func configureViews() {
        textFieldView.dismissKeyboard()
    }
    
    
    // MARK: - Dimiss Keyboard
    
    @objc private func tapped() {
        textFieldView.endEditing(true)
    }
    
    
    // MARK: - Configure TextFields
    
    private func configureTextFields() {
        surnameTextField.delegate = self
        nameTextField.delegate = self
        fatherNameTextField.delegate = self
    }
    
    private func configureOccupationView() {
        occupationView.set(data: ["Маркетолог", "Менеджер"])
        occupationView.changeCell(color: Colors.MainPage.purple.color)
        occupationView.changeCellText(color: .white)
        occupationView.leftPadding = 15
        occupationView.leftLabelPadding = 0
    }
    
    
    // MARK: - Set Components Colors
    
    private func setInitialStatesOfComponents() {
        let borderColor = Colors.Registration.borderColor.color
        let titleColor = Colors.Registration.titleDarkGray.color
        configureComponent(component: surnameTextField, borderColor: borderColor, titleColor: titleColor)
        configureComponent(component: nameTextField, borderColor: borderColor, titleColor: titleColor)
        configureComponent(component: fatherNameTextField, borderColor: borderColor, titleColor: titleColor)
        
        occupationView.changeTopText(color: titleColor)
        occupationView.changeBorder(color: borderColor)
    }
    
    private func configureComponent(component: TextField, borderColor: UIColor, titleColor: UIColor) {
        component.changeTitleColors(topTitleColor: titleColor, bottomTitleColor: titleColor)
        component.changeBorder(color: borderColor)
        component.bottomTitleText = ""
        component.buttonImage = nil
    }
    
    private func noDataIn(component: TextField) {
        shakeComponent(component: component)
        component.changeTitleColors(topTitleColor: Colors.Registration.red.color, bottomTitleColor: Colors.Registration.red.color)
        component.changeBorder(color: Colors.Registration.red.color)
        component.bottomTitleText = "Введите корректные данные"
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

extension RegistrationScreenViewController: RegistrationScreenViewInput {
    
    // MARK: - Missing Data in Component
    
    func noData(In: Int) {
        setInitialStatesOfComponents()
        textFieldView.endEditing(true)
        switch In {
        case 0:
            noDataIn(component: surnameTextField)
        case 1:
            noDataIn(component: nameTextField)
            acceptedData(component: surnameTextField)
        case 2:
            noDataIn(component: fatherNameTextField)
            acceptedData(component: nameTextField)
            acceptedData(component: surnameTextField)
        case 3:
            shakeComponent(component: occupationView)
            occupationView.changeTopText(color: Colors.Registration.red.color)
            acceptedData(component: nameTextField)
            acceptedData(component: surnameTextField)
            acceptedData(component: fatherNameTextField)
        default:
            break
        }
    }
    
    
    // MARK: - Return Data of Components
    
    func getData() -> (String?, String?, String?, String) {
        return (surnameTextField.text, nameTextField.text, fatherNameTextField.text, occupationView.getText() ?? "")
    }
    
    func setupInitialState() {
        configureButton()
        configureTextFields()
        configureViews()
        configureOccupationView()
    }
}

// MARK: - TextFieldDelegate Extension

extension RegistrationScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case surnameTextField:
            nameTextField.becomeFirstResponder()
        case nameTextField:
            fatherNameTextField.becomeFirstResponder()
        case fatherNameTextField:
            view.endEditing(true)
            occupationView.tableViewState = .shown
            setInitialStatesOfComponents()
            occupationView.changeBorder(color: Colors.MainPage.purple.color)
        default:
            break
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let color = Colors.Registration.purple.color
        setInitialStatesOfComponents()
        switch textField {
        case surnameTextField:
            surnameTextField.changeBorder(color: color)
        case nameTextField:
            nameTextField.changeBorder(color: color)
        case fatherNameTextField:
            fatherNameTextField.changeBorder(color: color)
        default:
            break
        }
    }
}
