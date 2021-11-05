//
//  HomeItem+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

var productImageAssociationKey: UInt8 = 0

/** Additions Extends HomeItem

*/
public extension HomeItem {
    
    public var productImage: UIImage? {
        
        get {
            
            return objc_getAssociatedObject(self, &productImageAssociationKey) as? UIImage
        }
        set {
            
            objc_setAssociatedObject(self, &productImageAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var uniqueIndexPath: IndexPath {
    
        return IndexPath(indexes: [Int(businessID), Int(identifier)])
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        
        guard let otherObject = object as? HomeItem else { return false }
        
        if self.identifier != otherObject.identifier { return false }
        if self.businessID != otherObject.businessID { return false }
        if self.listName != otherObject.listName { return false }
        if self.canBePaid != otherObject.canBePaid { return false }
        if self.canBeDeleted != otherObject.canBeDeleted { return false }
        if self.productDescription != otherObject.productDescription { return false }
        if self.shouldEnableAlert != otherObject.shouldEnableAlert { return false }
        if self.paymentDescription != otherObject.paymentDescription { return false }
        if self.amount != otherObject.amount { return false }
        if !StringExtension.equal(string1: self.linkedAccountDescription, string2: otherObject.linkedAccountDescription) { return false }
        if self.productImageURL != otherObject.productImageURL { return false }
        
        return true
    }
}
