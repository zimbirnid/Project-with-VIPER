//
//  TabBarViewController.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 15/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import UIKit
import SwinjectStoryboard

private enum Tabs: CaseIterable {
    case main
    case clients
    case add
    case workers
    case students
    
    var tabbarItem: UITabBarItem {
        switch self {
        case .main:
            return .init(
                title: Tabs.main.tabbarText,
                image: Icons.TabBar.InActive.imain.image,
                selectedImage: Icons.TabBar.Active.main.image
            )
        case .clients:
            return .init(
                title: Tabs.clients.tabbarText,
                image: Icons.TabBar.InActive.iclients.image,
                selectedImage: Icons.TabBar.Active.clients.image
            )
        case .add:
            return .init(
                title: Tabs.add.tabbarText,
                image: Icons.AddPage.addButton.image,
                selectedImage: Icons.AddPage.addButton.image
            )
        case .workers:
            return .init(
                title: Tabs.workers.tabbarText,
                image: Icons.TabBar.InActive.iworkers.image,
                selectedImage: Icons.TabBar.Active.workers.image
            )
        case .students:
            return .init(
                title: Tabs.students.tabbarText,
                image: Icons.TabBar.InActive.istudents.image,
                selectedImage: Icons.TabBar.Active.students.image
            )
        }
    }
    

    var viewController: UIViewController {
        let viewController: UIViewController!
        switch self {
        case .main:
            viewController = SwinjectStoryboard.createViewController(MainPageViewController.self)
        case .clients:
            viewController = SwinjectStoryboard.createViewController(ClientsPageViewController.self)
        case .add:
            viewController = SwinjectStoryboard.createViewController(AddPageViewController.self)
        case .workers:
            viewController = SwinjectStoryboard.createViewController(WorkersPageViewController.self)
        case .students:
            viewController = SwinjectStoryboard.createViewController(StudentsPageViewController.self)
        }
        viewController.tabBarItem = tabbarItem
        return viewController
    }

    var tabbarText: String {
        switch self {
        case .main:
            return "Главная"
        case .clients:
            return "Клиенты"
        case .add:
            return "Добавить"
        case .workers:
            return "Сотрудники"
        case .students:
            return "Студенты"
        }
    }
}

class TabBarViewController: UITabBarController, StoryboardLoadable {

    var output: TabBarViewOutput!

    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    private func configureTabs() {
        let viewControllers = Tabs.allCases.map { tab in
            return tab.viewController
        }
        self.viewControllers = viewControllers
    }
    
}



extension TabBarViewController: TabBarViewInput {

    func setupInitialState() {
        configureTabs()
        tabBar.barTintColor = .white
        tabBar.tintColor = Colors.MainPage.purple.color
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

