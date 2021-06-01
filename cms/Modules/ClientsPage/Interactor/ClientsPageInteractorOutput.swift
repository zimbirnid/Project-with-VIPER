//
//  ClientsPageClientsPageInteractorOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 26/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol ClientsPageInteractorOutput: class {
    func didGet(clients: [ClientModel], updateData: Bool)
    func didGetFail(message: String)
    func didGet(name: String)
}
