//
//  TPGroup+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/** Additions Extends TPGroup

 */
extension TPGroup: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        
        let newGroup = TPGroup(identifier: groupID, name: groupName, attributes: headerAttributes)
        return newGroup
    }
    
    public func compare(_ other: TPGroup) -> Foundation.ComparisonResult {
        
        return self.compare(other: other).foundationValue
    }
}
