//
//  MainCardDetailMainCardDetailInteractorInput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 23/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//

import Foundation

protocol MainCardDetailInteractorInput {
    func getDropDownData()
    func change(id: Int, data: Data)
}
