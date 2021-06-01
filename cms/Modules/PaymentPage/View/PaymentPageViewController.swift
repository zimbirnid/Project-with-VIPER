//
//  PaymentPageViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 20/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class PaymentPageViewController: BaseViewController {

    private lazy var paymentView: NewPaymentView = {
        let view = NewPaymentView()
        view.delegate = self
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var output: PaymentPageViewOutput!
    var client: ClientModel?
    

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        activityView.changeBackground(color: .clear)
        addSpinnerForRequest()
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

extension PaymentPageViewController: PaymentPageViewInput {
    func didGetMethods(methods: [MethodModel]) {
        paymentView.set(data: methods)
        removeSpinner()
    }

    func didGetFail(message: String) {
        showAlert(message: message, isOk: false)
    }
    
    func didGetSuccess() {
        removeSpinner()
    }

    func setupInitialState() {
        output.getMethods()
        view.addSubview(paymentView)
        NSLayoutConstraint.activate(
            [
                paymentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                paymentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                paymentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                paymentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ]
        )
    }
}

extension PaymentPageViewController: NewPaymentViewDelegate {
    func didGet(model: PaymentsPostModel) {
        output.didGet(model: model, client: client!)
        addSpinnerForRequest()
    }
    
    func cancelTapped() {
        output.dismiss()
    }
}
