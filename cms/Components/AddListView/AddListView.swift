//
//  AddListView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 31/3/21.
//

import UIKit

protocol AddListViewDelegate {
    func didCancelTapped()
    func didCellTapped(at: Int)
}

@IBDesignable
class AddListView: UIView {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .darkGray
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 14
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier())
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = Fonts.GothamPro.medium.font(size: 18)
        button.setTitleColor(Colors.MainPage.purple.color, for: .normal)
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableViewHeightConstraint: NSLayoutConstraint = {
        let const = NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        return const
    }()
    
    private lazy var viewBottomConstraint: NSLayoutConstraint = {
        let const = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 200)
        return const
    }()
    
    private var data = ["Заявка", "Сотрудник"]
    private var icons = [Icons.AddPage.newRequest.image, Icons.AddPage.newWorker.image]
    
    var delegate: AddListViewDelegate?
        
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSuviews()
        setupConstraints()
        backgroundColor = .clear
    }
    
    private func setupSuviews() {
        addSubview(backgroundView)
        addSubview(view)
        view.addSubview(button)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                backgroundView.topAnchor.constraint(equalTo: topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                viewBottomConstraint,
                view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -8),
                tableViewHeightConstraint,
                
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                button.heightAnchor.constraint(equalToConstant: 50),
                button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
        )
    }
    
    
    @objc private func tapped() {
        delegate?.didCancelTapped()
    }
    
    func viewWillAppear() {
        viewBottomConstraint.constant = -20
        UIView.animate(
            withDuration: 1/3,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut) { [weak self] in
            self?.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.tableViewHeightConstraint.constant = 105
            UIView.animate(
                withDuration: 1/3,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseOut) { [weak self] in
                self?.layoutIfNeeded()
            } completion: {_ in}
        }
    }
    
    func viewDidDisappear() {
        viewBottomConstraint.constant = 200
        tableViewHeightConstraint.constant = 0
    }
    
    private class Cell: UITableViewCell {
        
        private lazy var icon: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        private lazy var label: UILabel = {
            let label = UILabel()
            label.textColor = Colors.MainCardDetail.label.color
            label.backgroundColor = .clear
            label.font = Fonts.GothamPro.medium.font(size: 16)
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override func layoutSubviews() {
            super.layoutSubviews()
            setup()
        }
        
        private func setup() {
            setupSubivews()
            setupConstraints()
            backgroundColor = .white
            selectedBackgroundView = nil
        }
        
        private func setupSubivews() {
            addSubview(icon)
            addSubview(label)
        }
        
        private func setupConstraints() {
            NSLayoutConstraint.activate(
                [
                    icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                    icon.centerYAnchor.constraint(equalTo: centerYAnchor),
                    icon.heightAnchor.constraint(equalToConstant: 20),
                    icon.widthAnchor.constraint(equalToConstant: 20),
                    
                    label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
                    label.topAnchor.constraint(equalTo: topAnchor),
                    label.trailingAnchor.constraint(equalTo: trailingAnchor),
                    label.bottomAnchor.constraint(equalTo: bottomAnchor),
                ]
            )
        }
        
        func set(text: String) {
            label.text = text
        }
        
        func set(image: UIImage) {
            icon.image = image
        }
    }
}

extension AddListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {data.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier()) as? Cell else {return UITableViewCell()}
        cell.set(image: icons[indexPath.item])
        cell.set(text: data[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {52.5}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didCellTapped(at: indexPath.item)
    }
}
