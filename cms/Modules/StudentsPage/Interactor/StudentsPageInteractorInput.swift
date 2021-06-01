//
//  StudentsPageStudentsPageInteractorInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 27/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol StudentsPageInteractorInput {
    func getUsername()
    func getStudents(update: Bool)
    func filter(courses: [Int]?, statuses: [Int]?, occupations: [Int]?, positions: [Int]?, utms: [Int]?, update: Bool)
    func filterAgain()
}
