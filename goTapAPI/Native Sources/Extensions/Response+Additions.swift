//
//  Response+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 1/18/17.
//  Copyright © 2017 Tap Payments. All rights reserved.
//

/// Comparable extension for Response class.
public extension Response {
    
    public static func ==(lhs: Response, rhs: Response) -> Bool {
        
        return lhs.code == rhs.code
    }
    
    public static func !=(lhs: Response, rhs: Response) -> Bool {
        
        return !(lhs == rhs)
    }
}
