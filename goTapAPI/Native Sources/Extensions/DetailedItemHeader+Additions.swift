//
//  DetailedItemHeader+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/21/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/** Additions Extends DetailedItemHeader

*/
extension DetailedItemHeader {
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        
        let detailedHeaderCopy = super.copy(with: zone) as! DetailedItemHeader
        
        detailedHeaderCopy.headerDetailsID = headerDetailsID
        detailedHeaderCopy.amount = amount
        detailedHeaderCopy.linkID = linkID
        detailedHeaderCopy.displayValue = displayValue
        detailedHeaderCopy.headerDescription = headerDescription
        detailedHeaderCopy.isDefaultHeader = isDefaultHeader
        
        return detailedHeaderCopy
    }
}
