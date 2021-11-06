//
//  DateFormatter.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 9/28/16.
//  Copyright © 2016 Dennis Pashkov. All rights reserved.
//

public class DateFormatter : Foundation.DateFormatter {
    
    internal static func dateFormatterWith(localeIdentifier: String, dateFormat: String) -> DateFormatter {
        
        let formatter = DateFormatter()
        formatter.locale = Foundation.NSLocale(localeIdentifier: localeIdentifier) as Locale
        formatter.dateFormat = dateFormat
        
        return formatter
    }
    
    public func dateFromString(string: String) -> Date? {
        
        return self.date(from: string)
    }
}
