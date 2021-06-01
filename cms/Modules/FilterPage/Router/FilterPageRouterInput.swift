//
//  FilterPageFilterPageRouterInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 14/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol FilterPageRouterInput {
    func goBack()
    func didGetData(courses: [Int]?, statuses: [Int]?, occupations: [Int]?, positions: [Int]?, utms: [Int]?)
}
