//
//  Decimal+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 11/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

private let _zero = Decimal(0.0)

public extension Decimal {
    
    public var stringValue: String {
        
        return (self as NSDecimalNumber).stringValue
    }
    
    public static var zero: Decimal {
        
        return _zero
    }
}
