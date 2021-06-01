//
//  WorkersPageWorkersPageInteractorInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 26/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol WorkersPageInteractorInput {
    func getWorkers(update: Bool)
    func getUsername()
    func filter(courses: [Int]?, statuses: [Int]?, occupations: [Int]?, positions: [Int]?, utms: [Int]?, update: Bool)
    func filterAgain()
}
