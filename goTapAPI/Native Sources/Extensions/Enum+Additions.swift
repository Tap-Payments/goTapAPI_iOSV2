//
//  Enum+Additions.swift
//  Pods
//
//  Created by Dennis Pashkov on 10/3/16.
//
//

extension Enum {
    
    public override var hash: Int {
        
        return Int(self.rawValue)
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        
        guard let otherObject = object as? Enum else { return false }
        
        return self.rawValue == otherObject.rawValue
    }
}
