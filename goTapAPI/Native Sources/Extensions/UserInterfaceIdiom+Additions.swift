//
//  UserInterfaceIdiom+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/12/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/** Additions Extends UserInterfaceIdiom

*/
public extension UserInterfaceIdiom {
    
    /// Returns current user interface idiom.
    public static var current: goTapAPI.UserInterfaceIdiom {
        
        switch UIDevice.current.userInterfaceIdiom {
            
            case .phone:
            
                return goTapAPI.UserInterfaceIdiom.Phone
            
            case .pad:
            
                return goTapAPI.UserInterfaceIdiom.Tablet
            
            default:
            
                return goTapAPI.UserInterfaceIdiom.Other
        }
    }
}
