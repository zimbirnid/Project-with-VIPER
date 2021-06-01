//
//  StudentsPageStudentsPageViewOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 27/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

protocol StudentsPageViewOutput {

    /**
        @author zhakshylykov-f
        Notify presenter that view is ready
    */

    func viewIsReady()
    func getUsername()
    func getStudents(update: Bool)
    func cellTapped(with: ClientModel)
    func logoutTapped()
    func showFilterPage()
    func filter(courses: [Int]?, statuses: [Int]?, occupations: [Int]?, positions: [Int]?, utms: [Int]?, update: Bool)
    func filterAgain()
}
