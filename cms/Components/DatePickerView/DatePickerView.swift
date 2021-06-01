//
//  DatePickerView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 1/4/21.
//

import UIKit

@IBDesignable
class DatePickerView: UIView {
    
    private lazy var view: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.MainPage.borderColor.color.cgColor
        view.layer.cornerRadius = 4
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = Fonts.GothamPro.medium.font(size: 12)
        label.textColor = Colors.MainCardDetail.label.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = Fonts.GothamPro.regular.font(size: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru")
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePicker.backgroundColor = .white
        datePicker.layer.cornerRadius = 4
        datePicker.layer.borderWidth = 1
        datePicker.layer.borderColor = Colors.MainPage.borderColor.color.cgColor
        datePicker.setValue(UIColor.black, forKey: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru")
        formatter.dateStyle = .short
        return formatter
    }()
    
    private lazy var datePickerHeightConstraint: NSLayoutConstraint = {
        let const = NSLayoutConstraint(item: datePicker, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        return const
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
        dateChanged()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(view)
        addSubview(topTitle)
        view.addSubview(label)
        addSubview(datePicker)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                topTitle.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -15),
                topTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                
                view.topAnchor.constraint(equalTo: topAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
                view.heightAnchor.constraint(equalToConstant: 30),
                
                label.topAnchor.constraint(equalTo: view.topAnchor),
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                datePicker.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 8),
                datePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
                datePicker.trailingAnchor.constraint(equalTo: trailingAnchor),
                datePicker.bottomAnchor.constraint(equalTo: bottomAnchor),
                datePickerHeightConstraint,
            ]
        )
    }
    
    @objc private func dateChanged() {
        label.text = formatter.string(from: datePicker.date)
    }
    
    
    @objc private func tapped() {
        configureDatePickerHeight()
    }
    
    private func configureDatePickerHeight() {
        datePickerHeightConstraint.constant = datePickerHeightConstraint.constant == 0 ? 215 : 0
        UIView.animate(withDuration: 1/3) { [weak self] in
            guard let self = self else {return}
            self.layoutIfNeeded()
            self.superview?.layoutIfNeeded()
            self.superview?.superview?.layoutIfNeeded()
            self.superview?.superview?.superview?.layoutIfNeeded()
        }
    }
    
    func getJSONDate() -> String {
        return datePicker.date.toJSONStr()
    }
    
    func topTitle(text: String) {
        topTitle.text = text
    }
    
    func changeBorder(color: UIColor) {
        view.layer.borderColor = color.cgColor
    }
    
    func getDatePicker() -> UIDatePicker {
        return datePicker
    }
    
    func set(time: String?) {
        datePicker.date = time?.toDate() ?? Date()
        label.text = formatter.string(from: datePicker.date)
    }
}
