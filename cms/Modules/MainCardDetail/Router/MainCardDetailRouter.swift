//
//  MainCardDetailMainCardDetailRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 23/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class MainCardDetailRouter {
    weak var view: MainCardDetailViewController!
}


// MARK: - Router Input

extension MainCardDetailRouter: MainCardDetailRouterInput {
    func addPayment(client: ClientModel) {
        let vc = SwinjectStoryboard.createViewController(PaymentPageViewController.self)
        vc.client = client
        view.present(vc, animated: true, completion: nil)
    }
    
    func goToPrev() {
        view.navigationController?.popViewController(animated: true)
    }
}
