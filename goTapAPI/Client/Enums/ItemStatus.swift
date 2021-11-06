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
public class ItemStatus: Enum {
	
	public static let Active = ItemStatus(rawValue: 0)
	public static let Failed = ItemStatus(rawValue: 1)
	
	/// Returns string representation of the receiver.
	internal var stringRepresentation: String {
		
			if self == ItemStatus.Active {
			
			return Constants.Value.ACTIVE
		}
		else {
			
			return Constants.Value.FAILED
		}
	}
	
	/**
	 Initializes enum from its string representation.
	 
	 - parameter string: String representation.
	 
	 - returns: TPAPIItemStatus.
	 */
	internal static func with(stringValue string: String?) -> ItemStatus {
		
		guard string != nil else {
			
			return ItemStatus.Failed
		}
		
		switch string! {
			
		case Constants.Value.ACTIVE:
			
			return ItemStatus.Active
			
		case Constants.Value.FAILED:
			
			return ItemStatus.Failed
			
		default:
			
			return ItemStatus.Failed
		}
	}
}
