//
//  String+Additions.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 9/26/16.
//  Copyright © 2016 Dennis Pashkov. All rights reserved.
//

internal extension String {

    internal func Substring(loc: Int64, len: Int64) -> String {

        return (self as NSString).substring(with: NSMakeRange(Int(loc), Int(len)))
    }

    internal func Substring(_ from: Int64) -> String {

        return (self as NSString).substring(from: Int(from))
    }

    internal var Length: Int64 {

        return Int64(self.tap_length)
    }

    internal func Equals(string1: String?, string2: String?) -> Bool {

        return string1 == string2
    }

    internal func CompareToIgnoreCase(_ other: String) -> Int64 {

        return Int64(self.compare(other, options: String.CompareOptions.caseInsensitive, range: nil, locale: nil).rawValue)
    }

    internal func Replace(string1: String, string2: String) -> String {

        return self.replacingOccurrences(of: string1, with: string2)
    }

    internal func StartsWith(_ string: String) -> Bool {

        return self.hasPrefix(string)
    }

    internal func EndsWith(_ string: String) -> Bool {

        return self.hasSuffix(string)
    }

    internal func byRemovingAllCharacters(exceptCharactersFrom string: String) -> String {
        
        return self.tap_byRemovingAllCharactersExcept(string)
    }
    
    internal static func withFormat(_ format: String, _ args: [CVarArg]) -> String {
        
        return String(format: format, arguments: args)
    }
}
