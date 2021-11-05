//
//  TransactionResponseType.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/13/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 Transaction response type enum.
 
 - Success: Success.
 - Pending: Pending.
 - Other:   Other.
 */
public class TransactionResponseType: goTapAPI.Enum {
	
	public static let Success = TransactionResponseType(rawValue: 0)
	public static let Pending = TransactionResponseType(rawValue: 1)
	public static let Other = TransactionResponseType(rawValue: 2)
	
	internal static func with(intValue: Int64?) -> goTapAPI.TransactionResponseType {
		
		guard let value = intValue else {
		 
			return goTapAPI.TransactionResponseType.Other
		}
		
		switch value {
		 
			case 0:
				
				return goTapAPI.TransactionResponseType.Success
				
			case 1:
				
				return goTapAPI.TransactionResponseType.Pending
				
			default:
				
				return goTapAPI.TransactionResponseType.Other
		}
	}
}