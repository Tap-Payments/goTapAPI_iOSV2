//
//  Error+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/7/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/** Additions Extends Error

*/
public extension goTapAPI.APIError {
    
    public override var debugDescription: String {
        
        return "Error code: \(self.code), userIndo: \"\(self.userInfo)\""
    }
    
    public override var description: String {
        
        return debugDescription
    }
    
    public var nsError: NSError {
        
        guard let validUserInfo = JSONParseHelper.makeValidJSONObject(object: self.userInfo) as? [String: Any] else { fatalError("User info is not valid.") }
        
        return NSError(domain: self.userInfo[NSURLErrorDomain] as? String ?? goTapAPI.Constants.Error.domain, code: Int(self.code), userInfo: validUserInfo)
    }
    
    public static func ==(lhs: goTapAPI.APIError, rhs: goTapAPI.APIError) -> Bool {
        
        return lhs.code == rhs.code
    }
    
    public static func !=(lhs: goTapAPI.APIError, rhs: goTapAPI.APIError) -> Bool {
        
        return !(lhs == rhs)
    }
}
