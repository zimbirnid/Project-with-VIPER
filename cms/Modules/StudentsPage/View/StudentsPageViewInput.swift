//
//  StudentsPageStudentsPageViewInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 27/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol StudentsPageViewInput: class {

    /**
        @author zhakshylykov-f
        Setup initial state of the view
    */

    func setupInitialState()
    func didGetUser(name: String)
    func didGet(model: [ClientModel], updateData: Bool)
    func didGetFail(message: String)
}
