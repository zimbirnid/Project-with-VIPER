//
//  UITableViewCell+Extensions.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 2/3/21.
//

import Foundation
import UIKit

extension UITableViewCell {
    static func identifier() -> String {
        return String(describing: self)
    }
}
