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
public class ActionType: goTapAPI.Enum {
	 
	public static let None = goTapAPI.ActionType(rawValue: 0)
	public static let Refresh = goTapAPI.ActionType(rawValue: 1)
	public static let OpenURL = goTapAPI.ActionType(rawValue: 2)
	public static let SendSMS = goTapAPI.ActionType(rawValue: 3)
	public static let PhoneCall = goTapAPI.ActionType(rawValue: 4)
	
	/**
	 Initializes enum from string.
	 
	 - parameter string: String representation of enum.
	 
	 - returns: ActionType
	 */
	internal static func with(stringValue: String?) -> goTapAPI.ActionType {
		
		guard let string = stringValue else {
			
			return goTapAPI.ActionType.None
		}
		
		switch string {
			
			case goTapAPI.Constants.Value.NONE:
			
				return goTapAPI.ActionType.None
			
			case goTapAPI.Constants.Value.REFRESH:
			
				return goTapAPI.ActionType.Refresh
			
			case goTapAPI.Constants.Value.URL:
			
				return goTapAPI.ActionType.OpenURL
			
			case goTapAPI.Constants.Value.MSG:
			
				return goTapAPI.ActionType.SendSMS
			
			case goTapAPI.Constants.Value.CALL:
			
				return goTapAPI.ActionType.PhoneCall
			
			default:
			
				return goTapAPI.ActionType.None
		}
	}
}