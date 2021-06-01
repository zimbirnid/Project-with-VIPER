//
//  StudentsPageStudentsPageInteractorOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 27/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol StudentsPageInteractorOutput: class {
    func didGetUser(name: String)
    func didGet(model: [ClientModel], updateData: Bool)
    func didGetFail(message: String)
}
