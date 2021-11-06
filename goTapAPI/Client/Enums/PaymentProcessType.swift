//
//  PaymentProcessType.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/9/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 Payment process type enum.
 
 - WebPage:  Web page payment.
 - CardInfo: Card info payment.
 */
public class PaymentProcessType: Enum {
	
	public static let WebPage = PaymentProcessType(rawValue: 1)
	public static let CardInfo = PaymentProcessType(rawValue: 2)
	
	internal static func with(intValue: Int64?) -> PaymentProcessType {
		
		guard let value = intValue else {
		
			return PaymentProcessType.CardInfo
		}
		
		if value == 1 {
		 
			return PaymentProcessType.WebPage
		}
		else {
		 
			return PaymentProcessType.CardInfo
		}
	}
}
