//
//  EnumType.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/13/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

public protocol EnumType {
    
    static func ==(left: Self, right: Self) -> Bool
    
    static func !=(left: Self, right: Self) -> Bool
}
