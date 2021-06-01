//
//  AddPagePersonViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 03/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class AddPagePersonViewController: BaseViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private lazy var newRequestView: NewRequestView = {
        let view = NewRequestView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newWorkerView: NewWorkerView = {
        let view = NewWorkerView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var alertView: AlertView = {
        let view = AlertView()
        view.delegate = self
        view.set(icon: Icons.Alert.failure.image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var output: AddPagePersonViewOutput!
    var personNumber: Int?
    
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    private func configureID() {
        if let personNumber = personNumber {
            if personNumber == 0 {
                addComponent(component: newRequestView)
                newWorkerView.removeFromSuperview()
            } else {
                addComponent(component: newWorkerView)
                newRequestView.removeFromSuperview()
            }
        } else {
            output.goBack()
        }
    }
    
    private func addComponent<T: UIView>(component: T) {
        view.addSubview(component)
        NSLayoutConstraint.activate(
            [
                component.topAnchor.constraint(equalTo: view.topAnchor),
                component.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                component.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                component.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
        )
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

extension AddPagePersonViewController: AddPagePersonViewInput {
    
    func didGetFail(message: String) {
        showAlert(message: message, isOk: false)
    }
    
    func didGetSuccess() {
        removeSpinner()
    }
    
    func didGet(positions: [PositionModel]) {
        newWorkerView.set(data: positions, For: .occupation)
    }
    
    func didGet(courses: [CourseModel]) {
        newRequestView.set(data: courses, For: .course)
        newWorkerView.set(data: courses, For: .course)
    }
    
    func didGet(utms: [UTMModel]) {
        newRequestView.set(data: utms, For: .source)
    }
    
    func didGet(targets: [TargetModel]) {
        newRequestView.set(data: targets, For: .target)
    }
    
    func didGet(occupations: [OccupationModel]) {
        newRequestView.set(data: occupations, For: .type)
    }
    
    func didGet(statuses: [StatusModel]) {
        newRequestView.set(data: statuses, For: .status)
    }

    func setupInitialState() {
        configureID()
        output.getStatuses()
        output.getCourses()
        output.getOccuptions()
        output.getTargets()
        output.getUTMs()
        output.getPositions()
    }
}

extension AddPagePersonViewController: NewRequestViewDelegate {
    func cancelTapped() {
        output.goBack()
    }
    
    func didGetClient(data: Data) {
        output.didGetClient(data: data)
        addSpinnerForRequest()
    }
}

extension AddPagePersonViewController: NewWorkerViewDelegate {
    func didGetWorker(data: Data) {
        output.didGetWorker(data: data)
        addSpinnerForRequest()
    }
}

extension AddPagePersonViewController: AlertViewDelegate {
    func didSelfRemoved() {
        
    }
}
