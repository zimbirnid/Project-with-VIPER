//
//  WorkerDetailViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 11/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class WorkerDetailViewController: BaseViewController {

    private lazy var workerDetailView: WorkerDetailsView = {
        let view = WorkerDetailsView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var rightBarButton = UIBarButtonItem()
    var output: WorkerDetailViewOutput!
    var worker: TeacherModel?


    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addSpinnerForRequest()
    }
    
    private func addView() {
        view.addSubview(workerDetailView)
        NSLayoutConstraint.activate(
            [
                workerDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                workerDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                workerDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                workerDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
        )
    }
    
    private func configureId() {
        if let worker = worker {
            workerDetailView.set(worker: worker)
            title = worker.name
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
    
    @objc private func saveTapped() {
        if workerDetailView.isDataOk() {
            let data = workerDetailView.getData()
            output.change(id: workerDetailView.getWorkerID(), data: data)
        }
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

extension WorkerDetailViewController: WorkerDetailViewInput {
    
    func didGetFail(message: String) {
        showAlert(message: message, isOk: false)
    }
    
    func didGet(positions: [PositionModel]) {
        workerDetailView.set(data: positions, For: .occupation)
    }
    
    func didGet(courses: [CourseModel]) {
        workerDetailView.set(data: courses, For: .course)
        removeSpinner()
    }
    
    func setupInitialState() {
        addView()
        configureId()
        configureNavigationBar()
        output.getPositions()
        output.getCourses()
    }
}
