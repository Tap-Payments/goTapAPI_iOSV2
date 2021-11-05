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
public class PaymentProcessType: goTapAPI.Enum {
	
	public static let WebPage = goTapAPI.PaymentProcessType(rawValue: 1)
	public static let CardInfo = goTapAPI.PaymentProcessType(rawValue: 2)
	
	internal static func with(intValue: Int64?) -> goTapAPI.PaymentProcessType {
		
		guard let value = intValue else {
		
			return goTapAPI.PaymentProcessType.CardInfo
		}
		
		if value == 1 {
		 
			return goTapAPI.PaymentProcessType.WebPage
		}
		else {
		 
			return goTapAPI.PaymentProcessType.CardInfo
		}
	}
}