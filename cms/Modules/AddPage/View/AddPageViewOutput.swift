//
//  AddPageAddPageViewOutput.swift
//  cms_mobile
//
//  Created by zhakshylykov-f on 27/03/2021.
//  Copyright © 2021 Neolabs. All rights reserved.
//
import Foundation

protocol AddPageViewOutput {

    /**
        @author zhakshylykov-f
        Notify presenter that view is ready
    */

    func viewIsReady()
    func openPage(at: Int)
}
