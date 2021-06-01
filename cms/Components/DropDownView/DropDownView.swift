//
//  DropDownView.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 5/3/21.
//

import UIKit

protocol DropDownViewDelegate {
    func didSelectItem(dropDown: DropDownView, at: Int)
    func didBeginEditing(dropDown: DropDownView)
    func didEndEditing(dropDown: DropDownView)
}

@IBDesignable
class DropDownView: UIView {
    
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Registration.textDarkGray.color
        label.font = Fonts.GothamPro.regular.font(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var label: LabelWithPadding = {
        let label = LabelWithPadding()
        label.textColor = Colors.Registration.black.color
        label.font = Fonts.GothamPro.regular.font(size: 16)
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.setInsets(top: 0, bottom: 0, left: 8, right: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var view: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.layer.borderColor = Colors.MainPage.borderColor.color.cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.borderWidth = 1
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 4
        tableView.separatorColor = .clear
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var rightIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.TextFieldIcons.dropdown.image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tableViewHeightConstraint: NSLayoutConstraint = {
        let height = NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        return height
    }()
    
    private lazy var viewHeightConstraint: NSLayoutConstraint = {
        let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45)
        return height
    }()
    
    private lazy var labelLeadingConstraint: NSLayoutConstraint = {
        let const = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 8)
        return const
    }()
    
    private lazy var iconLeadingConstraint: NSLayoutConstraint = {
        let const = NSLayoutConstraint(item: rightIcon, attribute: .leading, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: 1, constant: 10)
        return const
    }()
    
    private lazy var iconTrailingConstraint: NSLayoutConstraint = {
        let const = NSLayoutConstraint(item: rightIcon, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -10)
        return const
    }()
    
    @IBInspectable var topText: String = "" {
        didSet {
            topTitle.text = topText
        }
    }
    
    @IBInspectable var height: CGFloat = 45 {
        didSet {
            viewHeightConstraint.constant = height
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 8 {
        didSet {
            labelLeadingConstraint.constant = leftPadding
        }
    }
    
    @IBInspectable var leftLabelPadding: CGFloat = 8 {
        didSet {
            label.setInsets(top: 0, bottom: 0, left: leftLabelPadding, right: leftLabelPadding)
            shouldSetFuckingColors = leftLabelPadding != 0
        }
    }
    private var shouldSetFuckingColors = false
    
    @IBInspectable var isIconMoveEnabled: Bool = false 
    
    enum TableViewState {
        case shown
        case hidden
    }
    
    var tableViewState: TableViewState = .hidden {
        didSet {
            let height = cellHeight * CGFloat(data.count)
            if tableViewState == .shown {
                tableViewHeightConstraint.constant = height
                changeBorder(color: Colors.MainPage.purple.color)
                delegate?.didBeginEditing(dropDown: self)
            } else {
                tableViewHeightConstraint.constant = 0
                changeBorder(color: Colors.MainPage.borderColor.color)
                delegate?.didEndEditing(dropDown: self)
            }
            changeHeight()
            rotateIcon(degree: tableViewState == .shown ? .pi : .pi * 2)
        }
    }
    
    private var cellHeight: CGFloat = 38
    private var cellBackgroundColor = UIColor.white
    private var cellTextColor = UIColor.black
    private var cellTextFont = Fonts.GothamPro.regular.font(size: 16)
    
    private var data = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var delegate: DropDownViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(topTitle)
        addSubview(view)
        view.addSubview(label)
        view.addSubview(rightIcon)
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                topTitle.bottomAnchor.constraint(equalTo: topAnchor, constant: -10),
                topTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
                
                view.topAnchor.constraint(equalTo: topAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                rightIcon.centerYAnchor.constraint(equalTo: label.centerYAnchor),
                rightIcon.heightAnchor.constraint(equalToConstant: 10),
                rightIcon.widthAnchor.constraint(equalToConstant: 10),
                iconTrailingConstraint,
                
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
                labelLeadingConstraint,
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
                
                tableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 5),
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ]
        )
        if isIconMoveEnabled {
            iconTrailingConstraint.isActive = false
            iconLeadingConstraint.isActive = true
        } else {
            iconTrailingConstraint.isActive = true
            iconLeadingConstraint.isActive = false
        }
        tableView.addConstraint(tableViewHeightConstraint)
        view.addConstraint(viewHeightConstraint)
    }
    
    @objc private func viewTapped() {
        tableViewState = tableViewState == .hidden ? .shown : .hidden
        if isIconMoveEnabled {
            moveIcon()
        }
    }
    
    private func moveIcon() {
        if tableViewState == .hidden {
            iconTrailingConstraint.isActive = false
            iconLeadingConstraint.isActive = true
        } else {
            iconTrailingConstraint.isActive = true
            iconLeadingConstraint.isActive = false
        }
        UIView.animate(withDuration: 1/3) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    private func changeHeight() {
        UIView.animate(withDuration: 1/3) { [weak self] in
            guard let self = self else {return}
            self.superview?.layoutIfNeeded()
            self.superview?.superview?.layoutIfNeeded()
            self.superview?.superview?.superview?.layoutIfNeeded()
            self.delegate?.didBeginEditing(dropDown: self)
        }
    }
}


// MARK: - Public methods

extension DropDownView {
    func changeCell(color: UIColor) {
        cellBackgroundColor = color
        tableView.reloadData()
    }
    func getText() -> String? {
        return label.text
    }
    func changeBorder(color: UIColor) {
        view.layer.borderColor = color.cgColor
    }
    func changeTopText(color: UIColor) {
        topTitle.textColor = color
    }
    func changeTopText(font: UIFont) {
        topTitle.font = font
    }
    func set(data: [String]) {
        self.data = data
    }
    func rotateIcon(degree: CGFloat) {
        rightIcon.rotate(by: degree)
    }
    func changeCellText(color: UIColor) {
        cellTextColor = color
        tableView.reloadData()
    }
    func changeCellText(font: UIFont) {
        cellTextFont = font
        tableView.reloadData()
    }
    func changeLabel(font: UIFont) {
        label.font = font
    }
    func changeLabelBackground(color: UIColor) {
        label.backgroundColor = color
    }
    func changeCell(height: CGFloat) {
        cellHeight = height
        tableView.reloadData()
    }
    func showTableView() {
        tableViewState = .shown
    }
    func hideTableView() {
        tableViewState = .hidden
    }
    func changeBorder(width: CGFloat) {
        view.layer.borderWidth = width
    }
    func set(text: String?) {
        label.text = text
        if shouldSetFuckingColors {
            label.setFuckingColors()
        }
    }
}


// MARK: - Cell

extension DropDownView {
    private class Cell: UITableViewCell {
        private lazy var title: UILabel = {
            let label = UILabel()
            label.font = Fonts.GothamPro.regular.font(size: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        override func layoutSubviews() {
            super.layoutSubviews()
            setup()
        }
        private func setup() {
            setupSubviews()
            setupConstraits()
            selectedBackgroundView = nil
        }
        private func setupSubviews() {
            addSubview(title)
        }
        private func setupConstraits() {
            NSLayoutConstraint.activate(
                [
                    title.topAnchor.constraint(equalTo: topAnchor),
                    title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                    title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                    title.bottomAnchor.constraint(equalTo: bottomAnchor),
                ]
            )
        }
        func setTitle(text: String?) {
            title.text = text
        }
        func changeText(color: UIColor) {
            title.textColor = color
        }
        func changeFont(font: UIFont) {
            title.font = font
        }
    }
}

extension DropDownView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {data.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier()) as? Cell else {return UITableViewCell()}
        cell.backgroundColor = cellBackgroundColor
        cell.changeText(color: cellTextColor)
        cell.setTitle(text: data[indexPath.item])
        cell.changeFont(font: cellTextFont)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {cellHeight}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        label.text = data[indexPath.item]
        if shouldSetFuckingColors {
            label.setFuckingColors()
        }
        tableViewState = .hidden
        delegate?.didSelectItem(dropDown: self, at: indexPath.item)
    }
}
