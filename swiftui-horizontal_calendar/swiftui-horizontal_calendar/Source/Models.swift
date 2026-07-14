//
//  Models.swift
//  swiftui-horizontal_calendar
//
//  Created by Huisoo on 7/14/26.
//

import Foundation

struct Day: Identifiable {
    var id: String = UUID().uuidString
    var value: Int
    var weekdaySymbol: String
    var date: Date
    var notFormThisMonth: Bool = false
}

struct Week: Identifiable {
    var id: String = UUID().uuidString
    var days: [Day]
    
    static func load(form date: Date, value: Int) -> Self {
        var days: [Day] = []
        let calendar = Calendar.current
        let weekdaySymbols = calendar.shortWeekdaySymbols
        
        let modifiedWeekDate = calendar.date(byAdding: .weekOfMonth, value: value, to: date) ?? .now
        
        if let interval = calendar.dateInterval(of: .weekOfMonth, for: modifiedWeekDate) {
            let startOfWeek = interval.start
            for index in 0..<7 {
                if let date = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                    let value = calendar.component(.day, from: date)
                    let symbolIndex = calendar.component(.weekday, from: date) - 1
                    let isCurrentMonth = calendar.isDate(date, equalTo: modifiedWeekDate, toGranularity: .month)
                    
                    days.append(
                        Day(value: value,
                            weekdaySymbol: weekdaySymbols[symbolIndex],
                            date: date,
                            notFormThisMonth: !isCurrentMonth)
                    )
                }
            }
        }
        
        return .init(days: days)
    }
}
