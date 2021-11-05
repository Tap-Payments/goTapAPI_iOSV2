//
//  Dictionary+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 9/26/16.
//  Copyright © 2016 Dennis Pashkov. All rights reserved.
//

internal extension Dictionary {
    
    internal var Keys: [String] {
        
        return (self as NSDictionary).allKeys as! [String]
    }
    
    internal var jsonString: String {
        
        guard let validJSONObject = JSONParseHelper.makeValidJSONObject(object: self) else { return "" }
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: validJSONObject, options: []) else { return "" }
        let jString = String(data: jsonData, encoding: String.Encoding.utf8)
        
        return jString ?? ""
    }
    
    internal static func from(_ jsonString: String?) -> Dictionary? {

        guard let nonnullJsonString = jsonString else { return nil }
        guard nonnullJsonString.hasPrefix("{") && nonnullJsonString.hasSuffix("}") else { return nil }
        
        guard let data = nonnullJsonString.data(using: String.Encoding.utf8) else { return nil }
        let parsedDictionary = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        
        return parsedDictionary as? Dictionary
    }
}
