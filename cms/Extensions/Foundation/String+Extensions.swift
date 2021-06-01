//
//  String+Extensions.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 12/3/21.
//

import Foundation
import UIKit

extension String {
    func isEmailOk() -> Bool {
        return contains("@") && contains(".")
    }
    
    func isPasswordOk() -> Bool {
        return count > 7
    }
    
    func isNameOk() -> Bool {
        if isEmpty {
            return false
        }
        for i in self {
            if i.isNumber || i.isMathSymbol || i.isSymbol || i.isPunctuation || i.isWhitespace || i.isWholeNumber {
                return false
            }
        }
        return true
    }
    
    func isTelephoneNumberOk() -> Bool {
        let num = replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "+996", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
        return num.count == 9
    }
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.locale = Locale(identifier: "ru")
        let date = formatter.date(from: self)
        if let date = date {
            formatter.dateStyle = .short
            return formatter.string(from: date)
        }
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = date {
            formatter.dateStyle = .short
            return formatter.string(from: date)
        }
        return formatter.string(from: Date())
    }
    
    func getTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.locale = Locale(identifier: "ru")
        let date = formatter.date(from: self)
        if let date = date {
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = date {
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
        return formatter.string(from: Date())
    }
    
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if let date = formatter.date(from: self) {
            return date
        }
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = formatter.date(from: self) {
            return date
        }
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: self) {
            return date
        }
        return Date()
    }
    
    func toAcronym() -> String {
        let words = split(separator: " ")
        if words.count == 1 {
            return self
        }
        var acr = ""
        for i in words {
            acr.append("\(i.first!)".uppercased())
        }
        return acr
    }
    
    func toBestStyle() -> String {
        var old = getOnlyNumbers()
        var new = ""
        if old.hasPrefix("996") {
            old = String(old.dropFirst(3))
        } else if old.prefix(1) == "0" {
            old.removeFirst()
        }
        for i in old.enumerated() {
            if [5, 7].contains(i.offset) {
                new += " "
            } else if i.offset == 0 {
                new += " ("
            } else if i.offset == 3 {
                new += ") "
            }
            new += String(i.element)
        }
        
        return "+996" + new
    }
    
    func getOnlyNumbers() -> String {
        components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    func getColorFromHex() -> UIColor {
        var colorString = trimmingCharacters(in: .whitespacesAndNewlines)
        colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()
        let alpha: CGFloat = 1.0
        let red: CGFloat = self.colorComponentFrom(colorString: colorString, start: 0, length: 2)
        let green: CGFloat = self.colorComponentFrom(colorString: colorString, start: 2, length: 2)
        let blue: CGFloat = self.colorComponentFrom(colorString: colorString, start: 4, length: 2)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    private func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {
        let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
        let endIndex = colorString.index(startIndex, offsetBy: length)
        let subString = colorString[startIndex..<endIndex]
        let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
        var hexComponent: UInt64 = 0
        guard Scanner(string: String(fullHexString)).scanHexInt64(&hexComponent) else {return 0}
        let hexFloat: CGFloat = CGFloat(hexComponent)
        let floatValue: CGFloat = CGFloat(hexFloat / 255.0)
        return floatValue
    }
}
