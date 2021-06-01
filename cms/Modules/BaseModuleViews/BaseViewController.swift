//
//  BaseViewController.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 16/4/21.
//

import UIKit

class BaseViewController: UIViewController, StoryboardLoadable {
    
    lazy var activityView: ActivityView = {
        let view = ActivityView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
