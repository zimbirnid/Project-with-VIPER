//
//  AddPageViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 27/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit

class AddPageViewController: BaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private lazy var addListView: AddListView = {
        let view = AddListView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var output: AddPageViewOutput!


    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addListView.viewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        addListView.viewDidDisappear()
    }
    
    private func addComponent<T: UIView>(component: T) {
        view.addSubview(component)
        NSLayoutConstraint.activate(
            [
                component.topAnchor.constraint(equalTo: view.topAnchor),
                component.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                component.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                component.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ]
        )
    }
}


// MARK: - View Input

extension AddPageViewController: AddPageViewInput {
    func setupInitialState() {
        addComponent(component: addListView)
    }
}

extension AddPageViewController: AddListViewDelegate {
    
    func didCancelTapped() {
        tabBarController?.selectedIndex = 0
    }
    
    func didCellTapped(at: Int) {
        output.openPage(at: at)
    }
}
