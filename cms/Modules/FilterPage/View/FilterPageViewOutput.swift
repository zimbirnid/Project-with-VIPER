//
//  FilterPageFilterPageViewOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 14/04/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol FilterPageViewOutput {

    /**
        @author zhakshylykov-f
        Notify presenter that view is ready
    */

    func viewIsReady()
    func getData()
    func didGetData(courses: [Int]?, statuses: [Int]?, occupations: [Int]?, positions: [Int]?, utms: [Int]?)
}
