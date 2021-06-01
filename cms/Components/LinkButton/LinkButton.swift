//
//  LinkButton.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 3/3/21.
//

import Foundation
import UIKit

@IBDesignable
class LinkButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        configureTitle()
    }
    
    private func configureTitle() {
        let attributes: [NSAttributedString.Key: Any] =
            [
                .font: Fonts.GothamPro.regular.font(size: 16),
                .foregroundColor: Colors.Registration.purple.color,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        let attributeString = NSMutableAttributedString(string: titleLabel?.text ?? "", attributes: attributes)
        setAttributedTitle(attributeString, for: .normal)
    }
}
