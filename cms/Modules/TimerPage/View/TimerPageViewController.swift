//
//  TimerPageViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 07/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class TimerPageViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var output: TimerPageViewOutput!
    var client: ClientModel?
    

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    private func configureNavigationBar() {
        title = "Таймер"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureClient() {
        if let client = client {
            tableView.reloadData()
            datePicker.date = client.timer?.toDate() ?? Date()
        } else {
            output.cancelTapped()
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier())
    }
    
    private func configureDatePicker() {
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.setValue(UIColor.black, forKey: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
    }
    
    @IBAction func cancelTapped() {
        output.cancelTapped()
    }
    
    @IBAction func saveTapped() {
        output.save(client: client!)
        addSpinnerForRequest()
    }
    
    @objc private func dateChanged() {
        if datePicker.datePickerMode == .date {
            guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? Cell else {return}
            cell.set(dateText: datePicker.date.getDate())
        } else {
            guard let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? Cell else {return}
            cell.set(dateText: datePicker.date.getTime())
        }
        client?.timer = datePicker.date.toTimerDate()
    }
    
    private class Cell: UITableViewCell {
        private lazy var title: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = Fonts.GothamPro.regular.font(size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private lazy var dateLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = Fonts.GothamPro.regular.font(size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override func layoutSubviews() {
            super.layoutSubviews()
            setup()
        }
        private func setup() {
            addSubview(title)
            addSubview(dateLabel)
            backgroundColor = .white
            selectedBackgroundView = nil
            NSLayoutConstraint.activate(
                [
                    title.topAnchor.constraint(equalTo: topAnchor),
                    title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                    title.bottomAnchor.constraint(equalTo: bottomAnchor),
                    
                    dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                    dateLabel.topAnchor.constraint(equalTo: topAnchor),
                    dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                ]
            )
        }
        
        func set(title: String) {
            self.title.text = title
        }
        func set(dateText: String) {
            dateLabel.text = dateText
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

extension TimerPageViewController: TimerPageViewInput {
    func setupInitialState() {
        configureNavigationBar()
        configureDatePicker()
        configureTableView()
        configureClient()
    }
    
    func didGetSuccess() {
        removeSpinner()
    }
    
    func didGetFail(message: String) {
        removeSpinner()
        showAlert(message: message, isOk: false)
    }
}


extension TimerPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {2}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier()) as? Cell else {return UITableViewCell()}
        if indexPath.item == 0 {
            cell.set(title: "Выбрать дату:")
            if let date = client?.timer {
                cell.set(dateText: date.toDate().getDate())
            }
        } else {
            cell.set(title: "Выбрать время:")
            if let date = client?.timer {
                cell.set(dateText: date.toDate().getTime())
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {44}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        datePicker.datePickerMode = indexPath.item == 0 ? .date : .time
    }
}
