//
//  Date+Extensions.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 2/4/21.
//

import Foundation

extension Date {
    func toJSONStr() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return formatter.string(from: self)
    }
    
    func getTomorrow() -> Date {
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let tomorrow = DateComponents(calendar: now.calendar, timeZone: now.timeZone, era: now.era, year: now.year, month: now.month, day: now.day! + 1, hour: now.hour, minute: now.minute, second: now.second, nanosecond: now.nanosecond, weekday: now.weekday, weekdayOrdinal: now.weekdayOrdinal, quarter: now.quarter, weekOfMonth: now.weekOfMonth, weekOfYear: now.weekOfYear, yearForWeekOfYear: now.yearForWeekOfYear)
        let dateTomorrow = Calendar.current.date(from: tomorrow)!
        return dateTomorrow
    }
    
    func getToday() -> Date {
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let today = DateComponents(calendar: now.calendar, timeZone: now.timeZone, era: now.era, year: now.year, month: now.month, day: now.day, hour: now.hour, minute: now.minute, second: now.second, nanosecond: now.nanosecond, weekday: now.weekday, weekdayOrdinal: now.weekdayOrdinal, quarter: now.quarter, weekOfMonth: now.weekOfMonth, weekOfYear: now.weekOfYear, yearForWeekOfYear: now.yearForWeekOfYear)
        let dateToday = Calendar.current.date(from: today)!
        return dateToday
    }
    
    func toTimerDate() -> String {
        let d = Calendar.current.dateComponents(in: .current, from: self)
        let dd =
            DateComponents(
                calendar: d.calendar,
                timeZone: d.timeZone,
                era: d.era,
                year: d.era,
                month: d.month,
                day: d.day,
                hour: d.hour,
                minute: d.minute,
                second: d.second,
                nanosecond: d.nanosecond! + 1111111112221,
                weekday: d.weekday,
                weekdayOrdinal: d.weekdayOrdinal,
                quarter: d.quarter,
                weekOfMonth: d.weekOfMonth,
                weekOfYear: d.weekOfYear,
                yearForWeekOfYear: d.yearForWeekOfYear
            )
        return Calendar.current.date(from: dd)!.toJSONStr()
    }
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.locale = Locale(identifier: "ru")
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
    
    func getTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.locale = Locale(identifier: "ru")
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
