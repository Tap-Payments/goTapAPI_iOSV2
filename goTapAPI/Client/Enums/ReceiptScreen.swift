//
//  ReceiptScreen.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 *  Receipt screen enum.
 */
public class ReceiptScreen: Option {
	
	public static let None = ReceiptScreen(rawValue: 0)
	public static let Email = ReceiptScreen(rawValue: 1 << 0)
	public static let ShareApp = ReceiptScreen(rawValue: 1 << 1)
	public static let GetRating = ReceiptScreen(rawValue: 1 << 2)
	public static let ShowName = ReceiptScreen(rawValue: 1 << 3)
}
