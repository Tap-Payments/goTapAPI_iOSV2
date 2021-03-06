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
public class QuickAddListResponseScreen: Enum {

	public static let Home = QuickAddListResponseScreen(rawValue: 0)
	public static let Confirmation = QuickAddListResponseScreen(rawValue: 1)
	public static let Accounts = QuickAddListResponseScreen(rawValue: 2)

	/**
	 Initializes enum value from string.

	 - parameter string: String.

	 - returns: IQuickAddListResponseScreen
	 */
	internal static func with(stringValue string: String?) -> QuickAddListResponseScreen {

		guard string != nil else {

			return Home
		}

		switch string! {

			case Constants.Value.HOME:

				return Home

			case Constants.Value.OPERATOR:

				return Confirmation

			case Constants.Value.ACCOUNTS:

				return Accounts

			default:

				return Home
		}
	}
}
