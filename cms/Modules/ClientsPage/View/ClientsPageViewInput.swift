//
//  ClientsPageClientsPageViewInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 26/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol ClientsPageViewInput: class {

    /**
        @author zhakshylykov-f
        Setup initial state of the view
    */

    func setupInitialState()
    func didGet(clients: [ClientModel], updateData: Bool)
    func didGet(name: String)
    func didGetFail(message: String)
}
