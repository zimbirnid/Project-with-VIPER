//
//  PaymentPagePaymentPageRouter.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 20/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import SwinjectStoryboard

class PaymentPageRouter {
    weak var view: PaymentPageViewController!
}


// MARK: - Router Input

extension PaymentPageRouter: PaymentPageRouterInput {
    func dismiss() {
        view.dismiss(animated: true, completion: nil)
    }
    
    func dismiss(sum: Int) {
        guard let presenter = view.presentingViewController?.children.last as? MainCardDetailViewController else {return}
        dismiss()
        presenter.navigationController?.popViewController(animated: true)
    }
}
