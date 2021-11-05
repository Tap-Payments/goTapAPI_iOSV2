//
//  JSONParseHelper.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/17/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

internal class JSONParseHelper {
    
    internal static func makeValidJSONObject(object: Any?) -> Any? {
        
        guard object != nil else { return nil }
        
        return self.processObject(object!)
    }
    
    private static func processObject(_ object: Any) -> Any {
        
        var result: Any
        if let dictionaryValue = object as? Dictionary<String, Any> {
            
            result = processDictionary(dictionaryValue)
        }
        else if let arrayValue = object as? Array<Any> {
            
            result = processArray(arrayValue)
        }
        else if let stringValue = object as? String {
            
            result = NSString(string: stringValue)
        }
        else if let doubleValue = object as? Double {
            
            result = NSNumber(value: doubleValue)
        }
        else if let int64Value = object as? Int64 {
            
            result = NSNumber(value: int64Value)
        }
        else if let intValue = object as? Int {
            
            result = NSNumber(value: intValue)
        }
        else if let boolValue = object as? Bool {
            
            result = NSNumber(value: boolValue)
        }
        else {
            
            result = object
        }
        
        return result
    }
    
    private static func processDictionary(_ dictionary: [String: Any]) -> [String: Any] {
        
        var result: [String: Any] = [:]
        
        for (key, value) in dictionary {
            
            result[key] = processObject(value)
        }
        
        return result
    }
    
    private static func processArray(_ array: [Any]) -> [Any] {
        
        var result: [Any] = []
        
        for object in array {
            
            result.append(processObject(object))
        }
        
        return result
    }
    
    private init() {}
}
