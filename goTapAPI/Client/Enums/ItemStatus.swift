//
//  ItemStatus.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/9/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 Item status enum
 
 - Active:			 Active item.
 - Failed:			 Failed item.
 */
public class ItemStatus: goTapAPI.Enum {
	
	public static let Active = goTapAPI.ItemStatus(rawValue: 0)
	public static let Failed = goTapAPI.ItemStatus(rawValue: 1)
	
	/// Returns string representation of the receiver.
	internal var stringRepresentation: String {
		
			if self == ItemStatus.Active {
			
			return goTapAPI.Constants.Value.ACTIVE
		}
		else {
			
			return goTapAPI.Constants.Value.FAILED
		}
	}
	
	/**
	 Initializes enum from its string representation.
	 
	 - parameter string: String representation.
	 
	 - returns: TPAPIItemStatus.
	 */
	internal static func with(stringValue string: String?) -> goTapAPI.ItemStatus {
		
		guard string != nil else {
			
			return goTapAPI.ItemStatus.Failed
		}
		
		switch string! {
			
		case goTapAPI.Constants.Value.ACTIVE:
			
			return goTapAPI.ItemStatus.Active
			
		case goTapAPI.Constants.Value.FAILED:
			
			return goTapAPI.ItemStatus.Failed
			
		default:
			
			return goTapAPI.ItemStatus.Failed
		}
	}
}