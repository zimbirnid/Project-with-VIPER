//
//  MainCardDetailMainCardDetailViewOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 23/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

protocol MainCardDetailViewOutput {

    /**
        @author zhakshylykov-f
        Notify presenter that view is ready
    */

    func viewIsReady()
    func getDropDownData()
    func goBack()
    func change(id: Int, data: Data)
    func addPayment(client: ClientModel)
}
