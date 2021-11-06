//
//  ComparisonResult+Additions.swift
//  Pods
//
//  Created by Dennis Pashkov on 10/18/16.
//
//

import Foundation

/** Additions Extends ComparisonResult

*/
public extension ComparisonResult {
    
    public var foundationValue: Foundation.ComparisonResult {
        
        switch self {
            
        case ComparisonResult.OrderedAscending:
            
            return .orderedAscending
            
        case ComparisonResult.OrderedDescending:
            
            return .orderedDescending
            
        case ComparisonResult.OrderedSame:
            
            return .orderedSame
            
        default:
            
            return .orderedSame
        }
    }
}
