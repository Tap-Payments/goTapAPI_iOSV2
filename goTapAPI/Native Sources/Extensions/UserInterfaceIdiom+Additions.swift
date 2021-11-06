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
    public static var current: UserInterfaceIdiom {
        
        switch UIDevice.current.userInterfaceIdiom {
            
            case .phone:
            
                return UserInterfaceIdiom.Phone
            
            case .pad:
            
                return UserInterfaceIdiom.Tablet
            
            default:
            
                return UserInterfaceIdiom.Other
        }
    }
}
