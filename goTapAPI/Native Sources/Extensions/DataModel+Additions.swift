//
//  DataModel+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 10/17/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/** Additions Extends DataModel

*/
extension DataModel: FileSerializable {
    
    public func save(to file: String) {
        
        type(of: self).save(array: [self], to: file)
    }
    
    public static func load<T>(from file: String) -> T? where T : DataModel {
        
        return loadArray(from: file)?.first
    }
    
    public static func save<T>(array: [T], to file: String) where T : DataModel {
        
        var strings: [String] = []
        for object in array {
            
            strings.append(object.jsonString)
        }
        
        let jsonString = (strings as NSObject).ToJson()
        guard let encryptedJSONString = Client.sharedInstance.dataSource?.encryptDictionary([Constants.Key.string: jsonString]) else { return }
        
        try? encryptedJSONString.write(toFile: file, atomically: true, encoding: String.Encoding.utf8)
    }
    
    public static func loadArray<T>(from file: String) -> [T]? where T : DataModel {
        
        guard let encryptedJSONString = try? String(contentsOfFile: file) else { return nil }
        guard let jsonString = Client.sharedInstance.dataSource?.selfDecryptDictionary(encryptedJSONString).parseString(forKey: Constants.Key.string) else { return nil }
        guard let jsonData = jsonString.data(using: String.Encoding.utf8) else { return nil }
        
        guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) else { return nil }
        guard let jsonArray = jsonObject as? [String] else { return nil }
        
        var result: [T] = []
        
        for objectJSONString in jsonArray {
            
            if let object = T().with(jString: objectJSONString) as? T {
                
                result.append(object)
            }
        }
        
        return result
    }
    
    public static func loadFrom(path: String) -> Self? {
        
        return self.load(from: path)
    }
}
