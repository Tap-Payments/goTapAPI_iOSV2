//
//  OptionType.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/13/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

public protocol OptionType: goTapAPI.EnumType {
    
    static func |(left: Self, right: Self) -> Self
    
    static func &(left: Self, right: Self) -> Self
    
    static func ^(left: Self, right: Self) -> Self
    
    static prefix func ~(left: Self) -> Self
    
    func contains(bit: Self) -> Bool
}
