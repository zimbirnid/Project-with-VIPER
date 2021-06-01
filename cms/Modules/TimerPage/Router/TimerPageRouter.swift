//
//  TimerPageTimerPageRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 07/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class TimerPageRouter {
    weak var view: TimerPageViewController!
}


// MARK: - Router Input

extension TimerPageRouter: TimerPageRouterInput {
    func dismiss() {
        if let presenter = view.presentingViewController?.children.first?.children.first as? MainPageViewController {
            presenter.output.getClients(byStatus: presenter.segmentBar.getSelectedItemId())
        }
        view.dismiss(animated: true, completion: nil)
    }
}
