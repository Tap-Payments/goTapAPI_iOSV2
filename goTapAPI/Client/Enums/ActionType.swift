//
//  ActionType.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 Enum with possible action types.
 
 - None:	  None action.
 - Refresh:   Refresh item action.
 - OpenURL:   Open URL action.
 - SendSMS:   Send SMS action.
 - PhoneCall: Phone call action.
 */
public class ActionType: Enum {
	 
	public static let None = ActionType(rawValue: 0)
	public static let Refresh = ActionType(rawValue: 1)
	public static let OpenURL = ActionType(rawValue: 2)
	public static let SendSMS = ActionType(rawValue: 3)
	public static let PhoneCall = ActionType(rawValue: 4)
	
	/**
	 Initializes enum from string.
	 
	 - parameter string: String representation of enum.
	 
	 - returns: ActionType
	 */
	internal static func with(stringValue: String?) -> ActionType {
		
		guard let string = stringValue else {
			
			return ActionType.None
		}
		
		switch string {
			
			case Constants.Value.NONE:
			
				return ActionType.None
			
			case Constants.Value.REFRESH:
			
				return ActionType.Refresh
			
			case Constants.Value.URL:
			
				return ActionType.OpenURL
			
			case Constants.Value.MSG:
			
				return ActionType.SendSMS
			
			case Constants.Value.CALL:
			
				return ActionType.PhoneCall
			
			default:
			
				return ActionType.None
		}
	}
}
