//
//  WorkersPageWorkersPageRouterInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 26/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol WorkersPageRouterInput {
    func cellTapped(with: TeacherModel)
    func logoutTapped()
    func showFilterPage()
}
