//
//  FilterView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 14/4/21.
//

import UIKit

protocol FilterViewDelegate {
    func didGetData(courses: [Int]?, statuses: [Int]?, occupations: [Int]?, positions: [Int]?, utms: [Int]?)
}

@IBDesignable
class FilterView: UIView {
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = Fonts.GothamPro.medium.font(size: 20)
        label.textColor = .black
        label.text = "Фильтр"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var courseView: SomeView = {
        let view = SomeView()
        view.setTop(text: "Курс:")
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var statusView: SomeView = {
        let view = SomeView()
        view.setTop(text: "Статус:")
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var occupationView: SomeView = {
        let view = SomeView()
        view.setTop(text: "Тип:")
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var positionView: SomeView = {
        let view = SomeView()
        view.setTop(text: "Должность:")
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var sourceView: SomeView = {
        let view = SomeView()
        view.setTop(text: "Источник:")
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var admitButton: EnterButton = {
        let button = EnterButton()
        button.setTitle("Применить", for: .normal)
        button.titleLabel?.font = Fonts.GothamPro.medium.font(size: 16)
        button.layer.cornerRadius = 4
        button.isInverseColor = false
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var cancelButton: EnterButton = {
        let button = EnterButton()
        button.setTitle("Сбросить", for: .normal)
        button.titleLabel?.font = Fonts.GothamPro.medium.font(size: 16)
        button.layer.cornerRadius = 4
        button.isInverseColor = true
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    enum Pages {
        case main
        case client
        case worker
        case student
    }
    
    enum Datas {
        case course
        case status
        case occupation
        case position
        case source
    }
    
    var currentPage: Pages = .client {
        didSet {
            setNeedsLayout()
        }
    }
    var delegate: FilterViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
        showAllLists()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
        backgroundColor = .white
    }
    
    private func setupSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(view)
        view.addSubview(title)
        view.addSubview(courseView)
        view.addSubview(admitButton)
        view.addSubview(cancelButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                scrollView.topAnchor.constraint(equalTo: topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                view.topAnchor.constraint(equalTo: scrollView.topAnchor),
                view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                view.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
                
                title.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
                title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                courseView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 14),
                courseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                courseView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ]
        )
        switch currentPage {
        case .client:
            removeSecondSegmentComponents()
            removeThirdSegmentComponents()
            addFirstSegmentComponents()
            
            courseView.currentPage = .client
            statusView.currentPage = .client
            occupationView.currentPage = .client
            positionView.currentPage = .client
            sourceView.currentPage = .client
        case .student:
            removeFirstSegmentComponents()
            removeThirdSegmentComponents()
            addSecondSegmentComponents()
            
            courseView.currentPage = .student
            statusView.currentPage = .student
            occupationView.currentPage = .student
            positionView.currentPage = .student
            sourceView.currentPage = .student
        case .worker:
            removeFirstSegmentComponents()
            removeSecondSegmentComponents()
            addThirdSegmentComponents()
            
            courseView.currentPage = .worker
            statusView.currentPage = .worker
            occupationView.currentPage = .worker
            positionView.currentPage = .worker
            sourceView.currentPage = .worker
        case .main:
            removeSecondSegmentComponents()
            removeThirdSegmentComponents()
            addFirstSegmentComponents()
            
            courseView.currentPage = .main
            statusView.currentPage = .main
            occupationView.currentPage = .main
            positionView.currentPage = .main
            sourceView.currentPage = .main
        }
        NSLayoutConstraint.activate(
            [
                admitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                admitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                admitButton.heightAnchor.constraint(equalToConstant: 40),

                cancelButton.topAnchor.constraint(equalTo: admitButton.bottomAnchor, constant: 14),
                cancelButton.leadingAnchor.constraint(equalTo: admitButton.leadingAnchor),
                cancelButton.trailingAnchor.constraint(equalTo: admitButton.trailingAnchor),
                cancelButton.heightAnchor.constraint(equalToConstant: 40),
                cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
            ]
        )
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        if sender == admitButton {
            delegate?.didGetData(
                courses: courseView.getData(),
                statuses: statusView.getData(),
                occupations: occupationView.getData(),
                positions: positionView.getData(),
                utms: sourceView.getData()
            )
        } else if sender == cancelButton {
            courseView.deselectAll()
            statusView.deselectAll()
            occupationView.deselectAll()
            positionView.deselectAll()
            sourceView.deselectAll()
        }
    }
    private func showAllLists() {
        courseView.tableViewState = .shown
        statusView.tableViewState = .shown
        occupationView.tableViewState = .shown
        positionView.tableViewState = .shown
        sourceView.tableViewState = .shown
    }
    
    func set<T: Decodable>(data: [T], For: Datas) {
        switch For {
        case .course:
            if let data = data as? [CourseModel] {
                courseView.set(data: data)
            }
        case .status:
            if let data = data as? [StatusModel] {
                switch currentPage {
                case .main:
                    statusView.set(data: data.filter({$0.doska!}))
                case .client:
                    statusView.set(data: data.filter({!$0.doska! && $0.name?.lowercased() != "записался на курс" && $0.name?.lowercased() != "запись на курс"}))
                case .worker:
                    statusView.set(data: data)
                case .student:
                    statusView.set(data: data.filter({$0.name?.lowercased() == "записался на курс" || $0.name?.lowercased() == "запись на курс"}))
                }
            }
        case .occupation:
            if let data = data as? [OccupationModel] {
                occupationView.set(data: data)
            }
        case .position:
            if let data = data as? [PositionModel] {
                positionView.set(data: data)
            }
        case .source:
            if let data = data as? [UTMModel] {
                sourceView.set(data: data)
            }
        }
        setNeedsLayout()
    }
}


// MARK: - Constraints methods

extension FilterView {
    private func addFirstSegmentComponents() {
        view.addSubview(statusView)
        view.addSubview(occupationView)
        view.addSubview(sourceView)
        NSLayoutConstraint.activate(
            [
                statusView.topAnchor.constraint(equalTo: courseView.bottomAnchor, constant: 14),
                statusView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                statusView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                occupationView.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 14),
                occupationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                occupationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                sourceView.topAnchor.constraint(equalTo: occupationView.bottomAnchor, constant: 14),
                sourceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                sourceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                sourceView.bottomAnchor.constraint(equalTo: admitButton.topAnchor, constant: -14),
            ]
        )
    }
    
    private func removeFirstSegmentComponents() {
        statusView.removeFromSuperview()
        occupationView.removeFromSuperview()
        sourceView.removeFromSuperview()
    }
    
    private func addSecondSegmentComponents() {
        view.addSubview(occupationView)
        view.addSubview(sourceView)
        NSLayoutConstraint.activate(
            [
                occupationView.topAnchor.constraint(equalTo: courseView.bottomAnchor, constant: 14),
                occupationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                occupationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                sourceView.topAnchor.constraint(equalTo: occupationView.bottomAnchor, constant: 14),
                sourceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                sourceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                sourceView.bottomAnchor.constraint(equalTo: admitButton.topAnchor, constant: -14),
            ]
        )
    }
    
    private func removeSecondSegmentComponents() {
        occupationView.removeFromSuperview()
        sourceView.removeFromSuperview()
    }
    
    private func addThirdSegmentComponents() {
        view.addSubview(occupationView)
        NSLayoutConstraint.activate(
            [
                occupationView.topAnchor.constraint(equalTo: courseView.bottomAnchor, constant: 14),
                occupationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                occupationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                occupationView.bottomAnchor.constraint(equalTo: admitButton.topAnchor, constant: -14),
            ]
        )
    }
    
    private func removeThirdSegmentComponents() {
        occupationView.removeFromSuperview()
    }
}


// MARK: - Some View

extension FilterView {
    private class SomeView: UIView, UITableViewDelegate, UITableViewDataSource {
        private lazy var label: UILabel = {
            let label = UILabel()
            label.font = Fonts.GothamPro.medium.font(size: 18)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private lazy var view: UIView = {
            let view = UIView()
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
            view.addGestureRecognizer(tap)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        private lazy var icon: UIImageView = {
            let view = UIImageView()
            view.image = Icons.TextFieldIcons.dropdown.image
            view.contentMode = .scaleAspectFit
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        private lazy var separator: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        private lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.backgroundColor = .white
            tableView.isScrollEnabled = false
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            tableView.separatorColor = Colors.MainPage.borderColor.color
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier())
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
        
        private lazy var tableViewHeightConstraint: NSLayoutConstraint = {NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)}()
        
        private var selected = [Bool]()
        private var data = [Any]() {
            didSet {
                tableView.reloadData()
                selected = Array(repeating: false, count: data.count)
            }
        }
        
        enum Pages {
            case main
            case client
            case worker
            case student
        }
        var currentPage: Pages = .main
        private var isAllSelected = false
        
        enum TableViewState {
            case shown
            case hidden
        }
        
        var tableViewState: TableViewState = .hidden {
            didSet {
                let height = 44 * CGFloat(data.count)
                if tableViewState == .shown {
                    tableViewHeightConstraint.constant = height
                } else {
                    tableViewHeightConstraint.constant = 0
                }
                changeHeight()
                rotateIcon(degree: tableViewState == .shown ? .pi : .pi * 2)
            }
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
            view.addSubview(label)
            view.addSubview(separator)
            view.addSubview(icon)
            addSubview(tableView)
        }
        
        private func setupConstraints() {
            NSLayoutConstraint.activate(
                [
                    view.topAnchor.constraint(equalTo: topAnchor),
                    view.leadingAnchor.constraint(equalTo: leadingAnchor),
                    view.trailingAnchor.constraint(equalTo: trailingAnchor),
                    view.heightAnchor.constraint(equalToConstant: 20),
                    
                    separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    separator.heightAnchor.constraint(equalToConstant: 1),
                    separator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    separator.bottomAnchor.constraint(equalTo: tableView.topAnchor),
                    
                    label.topAnchor.constraint(equalTo: view.topAnchor),
                    label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    
                    icon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
                    icon.heightAnchor.constraint(equalToConstant: 10),
                    icon.widthAnchor.constraint(equalToConstant: 10),
                    icon.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    
                    tableViewHeightConstraint,
                    tableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 5),
                    tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
                ]
            )
        }
        
        @objc private func tapped() {
            tableViewState = tableViewState == .shown ? .hidden : .shown
        }
        
        private func changeHeight() {
            UIView.animate(withDuration: 1/3) { [weak self] in
                guard let self = self else {return}
                self.layoutIfNeeded()
                self.superview?.layoutIfNeeded()
                self.superview?.superview?.layoutIfNeeded()
                self.separator.backgroundColor = self.tableViewState == .shown ? Colors.MainPage.borderColor.color : .white
            }
        }
        
        private func rotateIcon(degree: CGFloat) {
            icon.rotate(by: degree)
        }
        
        private class Cell: UITableViewCell {
            
            private lazy var label: UILabel = {
                let label = UILabel()
                label.font = Fonts.GothamPro.medium.font(size: 16)
                label.textColor = "#6F7782".getColorFromHex()
                label.numberOfLines = 0
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            private lazy var icon: UIImageView = {
                let icon = UIImageView()
                icon.image = Icons.FilterView.freeCircle.image
                icon.contentMode = .scaleAspectFit
                icon.translatesAutoresizingMaskIntoConstraints = false
                return icon
            }()
            
            var tapped = false {
                didSet {
                    icon.image = tapped ? Icons.FilterView.fillCircle.image : Icons.FilterView.freeCircle.image
                }
            }
            
            override func layoutSubviews() {
                super.layoutSubviews()
                setupSubviews()
                setupConstraints()
                backgroundColor = .white
                selectedBackgroundView = nil
            }
            
            private func setupSubviews() {
                addSubview(icon)
                addSubview(label)
            }
            
            private func setupConstraints() {
                NSLayoutConstraint.activate(
                    [
                        label.topAnchor.constraint(equalTo: topAnchor),
                        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                        label.trailingAnchor.constraint(equalTo: icon.leadingAnchor, constant: -5),
                        label.bottomAnchor.constraint(equalTo: bottomAnchor),
                        
                        icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                        icon.centerYAnchor.constraint(equalTo: centerYAnchor),
                        icon.heightAnchor.constraint(equalToConstant: 21),
                        icon.widthAnchor.constraint(equalToConstant: 21),
                    ]
                )
            }
            
            func set(text: String) {
                label.text = text
            }
        }
        
        func set<T: Decodable>(data: [T]) {
            self.data = data
        }
        
        func setTop(text: String) {
            label.text = text
        }
        
        func getData() -> [Int]? {
            if let data = data as? [CourseModel] {
                if isAllSelected {
                    return data.map({$0.id!})
                }
                var a = [CourseModel]()
                for i in 0..<data.count {
                    if selected[i] {
                        a.append(data[i])
                    }
                }
                return a.map({$0.id!})
            } else if let data = data as? [StatusModel] {
                if isAllSelected {
                    return data.map({$0.id!})
                }
                var a = [StatusModel]()
                for i in 0..<data.count {
                    if selected[i] {
                        a.append(data[i])
                    }
                }
                switch currentPage {
                case .main:
                    return data.filter({$0.doska!}).map({$0.id!})
                case .client:
                    return data.filter({!$0.doska! && $0.name?.lowercased() != "запись на курс" && $0.name?.lowercased() != "записался на курс"}).map({$0.id!})
                case .worker:
                    return a.map({$0.id!})
                case .student:
                    return data.filter({$0.name?.lowercased() == "запись на курс"}).map({$0.id!})
                }
                
            } else if let data = data as? [OccupationModel] {
                if isAllSelected {
                    return data.map({$0.id!})
                }
                var a = [OccupationModel]()
                for i in 0..<data.count {
                    if selected[i] {
                        a.append(data[i])
                    }
                }
                return a.map({$0.id!})
            } else if let data = data as? [PositionModel] {
                if isAllSelected {
                    return data.map({$0.id!})
                }
                var a = [PositionModel]()
                for i in 0..<data.count {
                    if selected[i] {
                        a.append(data[i])
                    }
                }
                return a.map({$0.id!})
            } else if let data = data as? [UTMModel] {
                if isAllSelected {
                    return data.map({$0.id!})
                }
                var a = [UTMModel]()
                for i in 0..<data.count {
                    if selected[i] {
                        a.append(data[i])
                    }
                }
                return a.map({$0.id!})
            }
            return nil
        }
        
        func deselectAll() {
            isAllSelected = false
            tableView.reloadData()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {data.count + 1}
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier()) as? Cell else {return UITableViewCell()}
            if indexPath.row == 0 {
                cell.set(text: "Выбрать все")
            } else if let item = data[indexPath.row - 1] as? CourseModel {
                cell.set(text: item.name!)
            } else if let item = data[indexPath.row - 1] as? StatusModel {
                cell.set(text: item.name!)
            } else if let item = data[indexPath.row - 1] as? UTMModel {
                cell.set(text: item.name!)
            } else if let item = data[indexPath.row - 1] as? OccupationModel {
                cell.set(text: item.name!)
            }
            cell.tapped = isAllSelected
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            guard let cell = tableView.cellForRow(at: indexPath) as? Cell else {return}
            if indexPath.row == 0 {
                isAllSelected = !isAllSelected
                tableView.reloadData()
            } else {
                guard let first = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? Cell else {return}
                first.tapped = false
                cell.tapped = !cell.tapped
                selected[indexPath.row - 1] = cell.tapped
            }
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {44}
    }
}
