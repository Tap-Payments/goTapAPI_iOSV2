//
//  QuickAddListResponseScreen.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/4/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 Screen to be opened after successful QuickAddList API call.

 - Home:         Home screen.
 - Confirmation: Services confirmation screen.
 - Accounts:     Accounts selection screen.
 */
public class QuickAddListResponseScreen: goTapAPI.Enum {

	public static let Home = goTapAPI.QuickAddListResponseScreen(rawValue: 0)
	public static let Confirmation = goTapAPI.QuickAddListResponseScreen(rawValue: 1)
	public static let Accounts = goTapAPI.QuickAddListResponseScreen(rawValue: 2)

	/**
	 Initializes enum value from string.

	 - parameter string: String.

	 - returns: IQuickAddListResponseScreen
	 */
	internal static func with(stringValue string: String?) -> goTapAPI.QuickAddListResponseScreen {

		guard string != nil else {

			return Home
		}

		switch string! {

			case goTapAPI.Constants.Value.HOME:

				return Home

			case goTapAPI.Constants.Value.OPERATOR:

				return Confirmation

			case goTapAPI.Constants.Value.ACCOUNTS:

				return Accounts

			default:

				return Home
		}
	}
}