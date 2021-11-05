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
public extension goTapAPI.ComparisonResult {
    
    public var foundationValue: Foundation.ComparisonResult {
        
        switch self {
            
        case goTapAPI.ComparisonResult.OrderedAscending:
            
            return .orderedAscending
            
        case goTapAPI.ComparisonResult.OrderedDescending:
            
            return .orderedDescending
            
        case goTapAPI.ComparisonResult.OrderedSame:
            
            return .orderedSame
            
        default:
            
            return .orderedSame
        }
    }
}
