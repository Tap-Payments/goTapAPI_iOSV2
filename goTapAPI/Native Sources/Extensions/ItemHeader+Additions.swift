//
//  ItemHeader+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/21/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/** Additions Extends ItemHeader

*/
extension ItemHeader: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        
        let headerCopy = type(of: self).init()
        
        headerCopy.identifier = identifier
        headerCopy.headerID = headerID
        headerCopy.name = name
        headerCopy.orderBy = orderBy
        headerCopy.fieldType = fieldType
        headerCopy.images = images
        
        return headerCopy
    }
}
