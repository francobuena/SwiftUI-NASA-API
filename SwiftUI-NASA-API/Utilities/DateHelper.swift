//
//  DateHelper.swift
//  SwiftUI-NASA-API
//
//  Created by Buena, Franco on 3/6/2022.
//

import Foundation

extension Date {
    static func getDate(forLastNDays nDays: Int) -> String {
        let cal = NSCalendar.current
        // start with today
        var date = cal.startOfDay(for: Date())
        
        // move back in time by one day:
        date = cal.date(byAdding: Calendar.Component.day, value: nDays, to: date)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
    }
}
