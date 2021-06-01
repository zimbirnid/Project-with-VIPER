//
//  LabelWithPadding.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 20/3/21.
//

import UIKit

class LabelWithPadding: UILabel {
    
    var textEdgeInsets = UIEdgeInsets.zero {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
        
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textEdgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textEdgeInsets.top, left: -textEdgeInsets.left, bottom: -textEdgeInsets.bottom, right: -textEdgeInsets.right)
        return textRect.inset(by: invertedInsets)
    }
        
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textEdgeInsets))
    }
    
    func setInsets(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        textEdgeInsets.top = top
        textEdgeInsets.bottom = bottom
        textEdgeInsets.left = left
        textEdgeInsets.right = right
    }
}
