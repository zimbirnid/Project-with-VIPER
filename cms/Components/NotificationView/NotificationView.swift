//
//  NotificationView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 24/3/21.
//

import UIKit

protocol NotificationDelegate {
    func didTapCell(client: ClientModel)
    func dismissNotification()
}

@IBDesignable
class NotificationView: UIView {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier())
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        view.alpha = 0.5
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableViewTopConstraint: NSLayoutConstraint = {
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 100)
    }()
    private lazy var tableViewHeightConstraint: NSLayoutConstraint = {
        let height = NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 86)
        return height
    }()
    
    private var data = [ClientModel]() {
        didSet {
            configureTableViewHeight()
            tableView.reloadData()
        }
    }
    
    private let cellHeight: CGFloat = 86
    var delegate: NotificationDelegate?
    
    @objc private func dismissView() {
        delegate?.dismissNotification()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(view)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: topAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                tableViewHeightConstraint,
                tableViewTopConstraint,
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            ]
        )
    }
    
    private func configureTableViewHeight() {
        let height = cellHeight * CGFloat(data.count)
        let maxVisibleHeight = frame.height
        tableViewHeightConstraint.constant = height < maxVisibleHeight ? height : maxVisibleHeight
        tableView.isScrollEnabled = height >= maxVisibleHeight - 100
    }
    
    func configure(models: [ClientModel]) {
        data = models
    }
}


extension NotificationView {
    private class Cell: UITableViewCell {
        private lazy var timerLabel: UILabel = {
            let label = UILabel()
            label.text = "Таймер истек"
            label.font = Fonts.GothamPro.bold.font(size: 12)
            label.textColor = .red
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private lazy var messageLabel: UILabel = {
            let label = UILabel()
            label.font = Fonts.GothamPro.medium.font(size: 12)
            label.textColor = Colors.MainPage.borderColor.color
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private lazy var nameLabel: UILabel = {
            let label = UILabel()
            label.font = Fonts.GothamPro.medium.font(size: 12)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private lazy var bellImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = Icons.TabBar.bell.image
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        private lazy var newView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        override func layoutSubviews() {
            super.layoutSubviews()
            setup()
        }
        
        private func setup() {
            setupSubviews()
            setupConstraints()
            backgroundColor = .clear
            selectedBackgroundView = nil
        }
        
        private func setupSubviews() {
            contentView.addSubview(newView)
            newView.addSubview(timerLabel)
            newView.addSubview(messageLabel)
            newView.addSubview(nameLabel)
            newView.addSubview(bellImageView)
        }
        
        private func setupConstraints() {
            NSLayoutConstraint.activate(
                [
                    newView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                    newView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    newView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    newView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                    
                    bellImageView.leadingAnchor.constraint(equalTo: newView.leadingAnchor, constant: 15),
                    bellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                    bellImageView.heightAnchor.constraint(equalToConstant: 30),
                    bellImageView.widthAnchor.constraint(equalToConstant: 30),
                    
                    timerLabel.topAnchor.constraint(equalTo: newView.topAnchor, constant: 5),
                    timerLabel.leadingAnchor.constraint(equalTo: bellImageView.trailingAnchor, constant: 15),
                    timerLabel.heightAnchor.constraint(equalToConstant: 15),
                    timerLabel.trailingAnchor.constraint(equalTo: newView.trailingAnchor, constant: -8),
                    
                    nameLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 5),
                    nameLabel.leadingAnchor.constraint(equalTo: bellImageView.trailingAnchor, constant: 15),
                    nameLabel.heightAnchor.constraint(equalToConstant: 15),
                    nameLabel.trailingAnchor.constraint(equalTo: newView.trailingAnchor, constant: -8),
                    
                    messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
                    messageLabel.leadingAnchor.constraint(equalTo: bellImageView.trailingAnchor, constant: 15),
                    messageLabel.heightAnchor.constraint(equalToConstant: 15),
                    messageLabel.trailingAnchor.constraint(equalTo: newView.trailingAnchor, constant: -8),
                ]
            )
        }
        
        func configure(model: ClientModel) {
            nameLabel.text = (model.name ?? "") + " " + (model.surname ?? "")
            messageLabel.text = model.target?.name
        }
    }
}

extension NotificationView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {data.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier()) as? Cell else {return UITableViewCell()}
        cell.configure(model: data[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {cellHeight}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didTapCell(client: data[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == 0 {
            tableViewTopConstraint.constant = 100
        } else {
            tableViewTopConstraint.constant = 0
        }
    }
}
