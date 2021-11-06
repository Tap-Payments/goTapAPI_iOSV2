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
public class TransactionResponseType: Enum {
	
	public static let Success = TransactionResponseType(rawValue: 0)
	public static let Pending = TransactionResponseType(rawValue: 1)
	public static let Other = TransactionResponseType(rawValue: 2)
	
	internal static func with(intValue: Int64?) -> TransactionResponseType {
		
		guard let value = intValue else {
		 
			return TransactionResponseType.Other
		}
		
		switch value {
		 
			case 0:
				
				return TransactionResponseType.Success
				
			case 1:
				
				return TransactionResponseType.Pending
				
			default:
				
				return TransactionResponseType.Other
		}
	}
}
