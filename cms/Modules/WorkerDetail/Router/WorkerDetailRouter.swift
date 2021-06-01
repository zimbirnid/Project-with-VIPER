//
//  WorkerDetailWorkerDetailRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 11/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class WorkerDetailRouter {
    weak var view: WorkerDetailViewController!
}


// MARK: - Router Input

extension WorkerDetailRouter: WorkerDetailRouterInput {
    func goBack() {
        view.navigationController?.popViewController(animated: true)
    }
}
