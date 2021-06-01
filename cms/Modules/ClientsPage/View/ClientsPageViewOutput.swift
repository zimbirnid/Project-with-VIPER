//
//  ClientsPageClientsPageViewOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 26/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol ClientsPageViewOutput {

    /**
        @author zhakshylykov-f
        Notify presenter that view is ready
    */

    func viewIsReady()
    func getUsername()
    func cellTapped(with: ClientModel)
    func getClients(update: Bool)
    func logoutTapped()
    func showFilterPage()
    func filter(courses: [Int]?, statuses: [Int]?, occupations: [Int]?, positions: [Int]?, utms: [Int]?, update: Bool)
    func filterAgain()
}
