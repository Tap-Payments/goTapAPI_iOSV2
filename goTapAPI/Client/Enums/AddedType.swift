//
//  Created by Dennis Pashkov on 12/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 *  Added type enum.
 */
public class AddedType: goTapAPI.Enum {
	
	public static let Unknown = goTapAPI.AddedType(rawValue: 0)
	public static let Manual = goTapAPI.AddedType(rawValue: 1)
	
	/**
	 Initializes enum from string.
	 
	 - parameter string: String representation of enum.
	 
	 - returns: AddedType.
	 */
	internal static func with(stringValue: String?) -> goTapAPI.AddedType {
	 
		guard let string = stringValue else {
		  
			return goTapAPI.AddedType.Unknown
		}
		 
		switch string {
		  
			case goTapAPI.Constants.Value.MANUAL:
				 
				return goTapAPI.AddedType.Manual
				
			default:
				
				return goTapAPI.AddedType.Unknown
		}
	}
}
