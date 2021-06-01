//
//  MainPageMainPageInteractorOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 15/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol MainPageInteractorOutput: class {
    func didGetStatusModel(models: [StatusModel])
    func didGetClientsModels(models: [ClientModel])
    func didGetNotifications(models: [ClientModel])
    func didGetFiltered(clients: [ClientModel], update: Bool)
    func didGet(userName: String)
    func didGetFail(message: String)
}
