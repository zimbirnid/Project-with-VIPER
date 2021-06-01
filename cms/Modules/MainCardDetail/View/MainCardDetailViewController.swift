//
//  MainCardDetailViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 23/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class MainCardDetailViewController: BaseViewController {
    
    private lazy var clientDetailView: ClientDetailsView = {
        let view = ClientDetailsView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var rightBarButton = UIBarButtonItem()
    
    var client: ClientModel?
    var output: MainCardDetailViewOutput!
    

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addSpinnerForRequest()
    }
    
    private func configureId() {
        if let client = client {
            clientDetailView.set(client: client)
            title = client.name
            let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        } else {
            output.goBack()
        }
    }
    
    private func configureNavigationBar() {
        rightBarButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveTapped))
        rightBarButton.tintColor = Colors.MainPage.purple.color
        navigationItem.rightBarButtonItem = rightBarButton
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureDetailView() {
        view.addSubview(clientDetailView)
        NSLayoutConstraint.activate(
            [
                clientDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                clientDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                clientDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                clientDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
        )
    }
    
    @objc private func saveTapped() {
        if clientDetailView.isDataOk() {
            let data = clientDetailView.getData()
            output.change(id: clientDetailView.getClientID(), data: data)
        }
    }
    
    func didGet(sum: Int) {
        clientDetailView.didGet(sum: sum)
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

extension MainCardDetailViewController: MainCardDetailViewInput {
    
    func didGetSuccess() {
        removeSpinner()
    }
    
    func didGetFail(message: String) {
        showAlert(message: message, isOk: false)
        removeSpinner()
    }
    
    func didGet(targets: [TargetModel]) {
        clientDetailView.set(data: targets, For: .target)
        removeSpinner()
    }
    
    func didGet(occupations: [OccupationModel]) {
        clientDetailView.set(data: occupations, For: .type)
    }
    func didGet(statuses: [StatusModel]) {
        clientDetailView.set(data: statuses, For: .status)
    }
    
    func didGet(courses: [CourseModel]) {
        clientDetailView.set(data: courses, For: .course)
    }
    
    func didGet(sources: [UTMModel]) {
        clientDetailView.set(data: sources, For: .source)
    }
    
    func setupInitialState() {
        configureId()
        output.getDropDownData()
        configureNavigationBar()
        configureDetailView()
    }
}

extension MainCardDetailViewController: ClientDetailsViewDelegate {
    func addPaymentTapped() {
        output.addPayment(client: client!)
    }
}
