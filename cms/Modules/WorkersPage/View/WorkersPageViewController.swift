//
//  WorkersPageViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 26/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class WorkersPageViewController: BaseViewController {

    @IBOutlet weak var topBar: TopBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    private lazy var logoutView: LogoutView = {
        let view = LogoutView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var output: WorkersPageViewOutput!
    
    var isFiltered = false
    var isFirstTime = true
    private var data = [TeacherModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var allData = [TeacherModel]() {
        didSet {
            searchBar.resignFirstResponder()
            searchBar.endEditing(true)
        }
    }

    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        if let text = searchBar.text, !text.isEmpty, text != "" {return}
        output.getWorkers(update: true)
        if isFirstTime {
            addSpinnerForRequest()
        }
        isFirstTime = false
    }
    
    private func configureTopBar() {
        topBar.delegate = self
        topBar.setTitle(title: "Сотрудники")
        output.getUsername()
        topBar.removeNotificationIcon()
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
        searchBar.setImage(Icons.FilterView.filter.image, for: .bookmark, state: .normal)
        searchBar.searchTextField.font = Fonts.GothamPro.regular.font(size: 14)
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.black
            }
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

extension WorkersPageViewController: WorkersPageViewInput {
    
    func didGetFail(message: String) {
        showAlert(message: message, isOk: false)
    }
    
    func didGet(name: String) {
        topBar.setProfileLetter(name: name)
        logoutView.set(name: name)
    }
    
    func didGet(workers: [TeacherModel], updateData: Bool) {
        if updateData {
            data = workers
            allData = workers
        } else {
            data.append(contentsOf: workers)
            allData.append(contentsOf: workers)
        }
        removeSpinner()
    }
    
    
    func setupInitialState() {
        configureTopBar()
        configureCollectionView()
        configureSearchBar()
    }
}

extension WorkersPageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {data.count}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkerCard.identifier(), for: indexPath) as? WorkerCard else {return UICollectionViewCell()}
        cell.configure(model: data[indexPath.item])
        if indexPath.item == data.count - 1 {
            isFiltered ? output.filterAgain() : output.getWorkers(update: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width-16, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {10}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {10}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        output.cellTapped(with: data[indexPath.item])
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        output.showFilterPage()
    }
}

extension WorkersPageViewController: UISearchBarDelegate {
    
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
        output.getWorkers(update: true)
        isFiltered = false
        searchBar.resignFirstResponder()
    }
}

extension WorkersPageViewController: LogoutViewDelegate {
    func logoutTapped() {
        logoutView.removeFromSuperview()
        output.logoutTapped()
    }
}

extension WorkersPageViewController: TopBarDelegate {
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
    
    func notificationButtonTapped() {}
}
