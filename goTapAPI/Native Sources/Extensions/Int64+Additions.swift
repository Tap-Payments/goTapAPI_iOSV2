//
//  Int64+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/6/18.
//  Copyright © 2018 Tap Payments. All rights reserved.
//

internal extension Int64 {
    
    internal var stringValue_EN_US: String {
        
        let formatter = NumberFormatter(locale: Locale.tap_enUS)
        
        if let result = formatter.string(from: NSNumber(value: self)) {
            
            return result
        }
        else {
            
            NSLog("failed to convert \(self) to string, using \"0\" as a result.")
            return "0"
        }
    }
}
