//
//  MainPageViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 15/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class MainPageViewController: BaseViewController {

    @IBOutlet weak var topBar: TopBar!
    @IBOutlet weak var segmentBar: SegmentView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    private lazy var logoutView: LogoutView = {
        let view = LogoutView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var notificationView: NotificationView = {
        let view = NotificationView()
        view.delegate = self
        view.frame = self.view.frame
        view.frame.size.height = self.view.frame.height - (tabBarController?.tabBar.frame.height ?? 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var output: MainPageViewOutput!
    
    private var data = [ClientModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var allData = [ClientModel]() {
        didSet {
            searchBar.resignFirstResponder()
            searchBar.endEditing(true)
        }
    }
    
    var isFiltered = false
    private var isFirstTime = true

    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        if isFirstTime {
            addSpinnerForRequest()
        } else {            
            output.getClients(byStatus: segmentBar.getSelectedItemId())
        }
        isFirstTime = false
    }
    
    private func configureSegmentBar() {
        output.getStatuses()
    }
    
    @objc private func segmentChanged(_ sender: UIButton) {
        output.getClients(byStatus: segmentBar.getSelectedItemId())
    }
    
    private func configureTopBar() {
        topBar.setTitle(title: "Главная")
        topBar.delegate = self
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.setValue("Отмена", forKey: "cancelButtonText")
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.font = Fonts.GothamPro.regular.font(size: 14)
        searchBar.setImage(Icons.FilterView.filter.image, for: .bookmark, state: .normal)
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.black
            }
        }
    }
    
    @objc private func timerPressed(_ sender: UIButton) {
        guard let model = data.filter({$0.clientID == sender.tag}).first else {return}
        output.timerPressed(client: model)
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
    
    func callFilter(
        courses: [Int]?,
        statuses: [Int]?,
        occupations: [Int]?,
        positions: [Int]?,
        utms: [Int]?,
        update: Bool
    ) {
        output.filter(
            courses: courses,
            statuses: statuses,
            occupations: occupations,
            positions: positions,
            utms: utms,
            update: update
        )
        isFiltered = true
        addSpinnerForRequest()
    }
}


// MARK: - View Input

extension MainPageViewController: MainPageViewInput {
    
    func didGetFail(message: String) {
        showAlert(message: message, isOk: false)
    }
    
    func didGetFiltered(clients: [ClientModel], update: Bool) {
        if update {
            data = clients
            allData = clients
        } else {
            data.append(contentsOf: clients)
            allData.append(contentsOf: clients)
        }
        removeSpinner()
    }
    
    func didGet(userName: String) {
        topBar.setProfileLetter(name: userName)
        logoutView.set(name: userName)
    }
    
    func didGetNotifications(models: [ClientModel]) {
        notificationView.configure(models: models)
        if models.isEmpty {
            topBar.dismissNotification()
        } else {
            topBar.didGetNotifications()
        }
    }
    
    func didGetClientsModels(models: [ClientModel]) {
        data = models
        allData = models
        removeSpinner()
    }
    
    func didGetStatusModel(models: [StatusModel]) {
        segmentBar.setup(models: models)
        output.getClients(byStatus: segmentBar.getSelectedItemId())
        segmentBar.addTargets(self, action: #selector(segmentChanged(_:)), For: .touchUpInside)
    }

    func setupInitialState() {
        configureTopBar()
        configureSegmentBar()
        configureCollectionView()
        output.getUsername()
        configureSearchBar()
    }
}


extension MainPageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {data.count}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCard.identifier(), for: indexPath) as? MainCard else {return UICollectionViewCell()}
        cell.configure(model: data[indexPath.row])
        cell.addTargetToButton(self, action: #selector(timerPressed(_:)), For: .touchUpInside)
        if isFiltered && indexPath.row == data.count - 1 {
            output.filterAgain()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width-16, height: 174)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {10}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {10}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        output.cellTapped(with: data[indexPath.row])
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        output.showFilterPage()
    }
}


extension MainPageViewController: NotificationDelegate {
    func didTapCell(client: ClientModel) {
        dismissNotification()
        output.cellTapped(with: client)
    }
    
    func dismissNotification() {
        notificationView.removeFromSuperview()
    }
}


extension MainPageViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        data = allData.filter { model -> Bool in
            if let name = model.name?.lowercased() {
                if let surname = model.surname?.lowercased() {
                    if let fatherName = model.patronymic?.lowercased() {
                        if let phone = model.phoneNo?.lowercased() {
                            return name.contains(searchText.lowercased()) || surname.contains(searchText.lowercased()) || fatherName.contains(searchText.lowercased()) || phone.contains(searchText.lowercased())
                        }
                        return name.contains(searchText.lowercased()) || surname.contains(searchText.lowercased()) || fatherName.contains(searchText.lowercased())
                    }
                    return name.contains(searchText.lowercased()) || surname.contains(searchText.lowercased())
                }
                return name.contains(searchText.lowercased())
            } else if let surname = model.surname?.lowercased() {
                if let fatherName = model.patronymic?.lowercased() {
                    if let phone = model.phoneNo?.lowercased() {
                        return surname.contains(searchText.lowercased()) || fatherName.contains(searchText.lowercased()) || phone.contains(searchText.lowercased())
                    }
                    return surname.contains(searchText.lowercased()) ||
                        fatherName.contains(searchText.lowercased())
                }
                return surname.contains(searchText.lowercased())
            } else if let fatherName = model.patronymic?.lowercased() {
                if let phone = model.phoneNo?.lowercased() {
                    return fatherName.contains(searchText.lowercased()) || phone.contains(searchText.lowercased())
                }
                return fatherName.contains(searchText.lowercased())
            } else if let phone = model.phoneNo?.lowercased() {
                return phone.contains(searchText.lowercased())
            }
            return false
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.showsBookmarkButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.showsBookmarkButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        data = allData
        output.getClients(byStatus: segmentBar.getSelectedItemId())
        searchBar.resignFirstResponder()
    }
}


extension MainPageViewController: LogoutViewDelegate {
    func logoutTapped() {
        logoutView.removeFromSuperview()
        output.logoutTapped()
    }
}

extension MainPageViewController: TopBarDelegate {
    func profileButtonTapped() {
        view.addSubview(logoutView)
        NSLayoutConstraint.activate(
            [
                logoutView.topAnchor.constraint(equalTo: view.topAnchor),
                logoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                logoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                logoutView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ]
        )
    }
    
    func notificationButtonTapped() {
        view.addSubview(notificationView)
        NSLayoutConstraint.activate(
            [
                notificationView.topAnchor.constraint(equalTo: view.topAnchor),
                notificationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                notificationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                notificationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(tabBarController?.tabBar.frame.height ?? 0)),
            ]
        )
    }
}
