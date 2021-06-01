//
//  MainPageMainPageInteractorInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 15/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol MainPageInteractorInput {
    func getUsername()
    func getStatuses()
    func getClients(byStatus: String)
    func filter(courses: [Int]?, statuses: [Int]?, occupations: [Int]?, positions: [Int]?, utms: [Int]?, update: Bool)
    func filterAgain()
}
