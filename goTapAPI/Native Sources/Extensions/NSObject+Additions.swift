//
//  NSObject+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 9/27/16.
//  Copyright © 2016 Dennis Pashkov. All rights reserved.
//

import Foundation

internal extension NSObject {
    
    internal func ToJson() -> String {
        
        let fixedJsonObject = JSONParseHelper.makeValidJSONObject(object: self)
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: fixedJsonObject!, options: []) else {
            
            return ""
        }
        
        guard let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else {
            
            return ""
        }
        
        return jsonString
    }
    
    internal static func FromJson(string: String) -> AnyObject? {
        
        guard let jsonData = string.data(using: String.Encoding.utf8, allowLossyConversion: true) else { return nil }
        return (try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments)) as AnyObject?
    }
}
