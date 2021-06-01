//
//  MainPageMainPageRouterInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 15/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol MainPageRouterInput {
    func cellTapped(with: ClientModel)
    func logoutTapped()
    func timerPressed(client: ClientModel)
    func showFilterPage()
}
