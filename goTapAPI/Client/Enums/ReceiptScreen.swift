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
public class ReceiptScreen: goTapAPI.Option {
	
	public static let None = goTapAPI.ReceiptScreen(rawValue: 0)
	public static let Email = goTapAPI.ReceiptScreen(rawValue: 1 << 0)
	public static let ShareApp = goTapAPI.ReceiptScreen(rawValue: 1 << 1)
	public static let GetRating = goTapAPI.ReceiptScreen(rawValue: 1 << 2)
	public static let ShowName = goTapAPI.ReceiptScreen(rawValue: 1 << 3)
}