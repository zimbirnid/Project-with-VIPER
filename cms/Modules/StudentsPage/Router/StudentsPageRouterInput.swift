//
//  StudentsPageStudentsPageRouterInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 27/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol StudentsPageRouterInput {
    func cellTapped(with: ClientModel)
    func logoutTapped()
    func showFilterPage()
}
