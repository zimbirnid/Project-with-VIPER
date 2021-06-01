//
//  FilterPageViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 14/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class FilterPageViewController: BaseViewController {

    @IBOutlet weak var filterView: FilterView!
    var output: FilterPageViewOutput!
    
    enum Pages {
        case main
        case client
        case worker
        case student
    }
    
    var currentPage: Pages = .client

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        addSpinnerForRequest()
    }
    
    private func configureFilterView() {
        switch currentPage {
        case .client:
            filterView.currentPage = .client
        case .worker:
            filterView.currentPage = .worker
        case .student:
            filterView.currentPage = .student
        case .main:
            filterView.currentPage = .main
        }
        filterView.delegate = self
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

extension FilterPageViewController: FilterPageViewInput {
    func didGet(statuses: [StatusModel]) {
        filterView.set(data: statuses, For: .status)
    }
    
    func didGet(courses: [CourseModel]) {
        filterView.set(data: courses, For: .course)
    }
    
    func didGet(occupations: [OccupationModel]) {
        filterView.set(data: occupations, For: .occupation)
    }
    
    func didGet(positions: [PositionModel]) {
        filterView.set(data: positions, For: .position)
    }
    
    func didGet(utms: [UTMModel]) {
        filterView.set(data: utms, For: .source)
        removeSpinner()
    }
    
    func didGetSuccess() {
        removeSpinner()
    }
    
    func didGetFail(message: String) {
        showAlert(message: message, isOk: false)
    }
    
    func setupInitialState() {
        output.getData()
        configureFilterView()
    }
}

extension FilterPageViewController: FilterViewDelegate {
    func didGetData(courses: [Int]?, statuses: [Int]?, occupations: [Int]?, positions: [Int]?, utms: [Int]?) {
        output.didGetData(courses: courses, statuses: statuses, occupations: occupations, positions: positions, utms: utms)
        addSpinnerForRequest()
    }
}
