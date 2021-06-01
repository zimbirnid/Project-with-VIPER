//
//  MainPageMainPageViewOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 15/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol MainPageViewOutput {

    /**
        @author zhakshylykov-f
        Notify presenter that view is ready
    */

    func viewIsReady()
    func getUsername()
    func getStatuses()
    func getClients(byStatus: String)
    func cellTapped(with: ClientModel)
    func logoutTapped()
    func timerPressed(client: ClientModel)
    func showFilterPage()
    func filter(courses: [Int]?, statuses: [Int]?, occupations: [Int]?, positions: [Int]?, utms: [Int]?, update: Bool)
    func filterAgain()
}
