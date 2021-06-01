//
//  MainPageMainPageViewInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 15/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol MainPageViewInput: class {

    /**
        @author zhakshylykov-f
        Setup initial state of the view
    */

    func setupInitialState()
    func didGetStatusModel(models: [StatusModel])
    func didGetClientsModels(models: [ClientModel])
    func didGetNotifications(models: [ClientModel])
    func didGetFiltered(clients: [ClientModel], update: Bool)
    func didGet(userName: String)
    func didGetFail(message: String)
}
