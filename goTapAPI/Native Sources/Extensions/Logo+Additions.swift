//
//  Logo+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 1/24/17.
// Copyright © 2017 Tap Payments. All rights reserved.
//

private var logoImageAssociationKey: UInt8 = 0

/// Useful extension for Logo class.
public extension Logo {
    
    /// Presaved logo image.
    public var logoImage: UIImage? {
        
        get {
            
            return objc_getAssociatedObject(self, &logoImageAssociationKey) as? UIImage
        }
        set {
            
            objc_setAssociatedObject(self, &logoImageAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        
        guard let otherLogo = object as? Logo else { return false }
        
        if self.screenID != otherLogo.screenID { return false }
        if self.businessID != otherLogo.businessID { return false }
        if self.isdNumber != otherLogo.isdNumber { return false }
        if self.logoID != otherLogo.logoID { return false }
        
        return self.url == otherLogo.url
    }
}
