//
//  Array+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 9/28/16.
//  Copyright © 2016 Dennis Pashkov. All rights reserved.
//

internal extension Array {
    
    internal func toArray() -> [AnyObject] {
        
        return self as [AnyObject]
    }
    
    internal static func from(jsonString: String?) -> Array? {
        
        guard let nonnullJsonString = jsonString else { return nil }
        guard nonnullJsonString.hasPrefix("[") && nonnullJsonString.hasSuffix("]") else { return nil }
        
        guard let data = nonnullJsonString.data(using: String.Encoding.utf8) else { return nil }
        let parsedArray = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        
        return parsedArray as? Array
    }
}

internal extension NSArray {
    
    internal func asArrayOf<T>(_ type: T.Type) -> [T] where T: Any {
        
        var result: [T] = []
        
        for object in self {
            
            if let tObject = object as? T {
                
                result.append(tObject)
            }
        }
        
        return result
    }
}
