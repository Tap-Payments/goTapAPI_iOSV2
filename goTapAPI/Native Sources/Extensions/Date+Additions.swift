//
//  Date+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 9/28/16.
//  Copyright © 2016 Dennis Pashkov. All rights reserved.
//

internal extension Date {
    
    internal init(_ year: Int, _ month: Int, _ day: Int) {
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        self.init(timeIntervalSince1970: calendar.date(from: dateComponents)?.timeIntervalSince1970 ?? 0)
    }
    
    internal func CompareTo(_ other: Date) -> Int64 {
        
        return Int64(self.compare(other).rawValue)
    }
}
