//
//  Created by Dennis Pashkov on 12/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 *  Added type enum.
 */
public class AddedType: Enum {
	
	public static let Unknown = AddedType(rawValue: 0)
	public static let Manual = AddedType(rawValue: 1)
	
	/**
	 Initializes enum from string.
	 
	 - parameter string: String representation of enum.
	 
	 - returns: AddedType.
	 */
	internal static func with(stringValue: String?) -> AddedType {
	 
		guard let string = stringValue else {
		  
			return AddedType.Unknown
		}
		 
		switch string {
		  
			case Constants.Value.MANUAL:
				 
				return AddedType.Manual
				
			default:
				
				return AddedType.Unknown
		}
	}
}
