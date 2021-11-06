//
//  AddToListScreen.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/3/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 *  Add to list screen enum.
 */
public class AddToListScreen: Option {

	/// None. Default value.
	public static let None = AddToListScreen(rawValue: 0)

	/// Mobile screen.
	public static let Mobile = AddToListScreen(rawValue: 1 << 0)

	/// ID screen.
	public static let ID = AddToListScreen(rawValue: 1 << 1)

	/// ID screen with camera button enabled.
	public static let IDCameraButtonEnabled = AddToListScreen(rawValue: 1 << 2)

	/// Mobile intro screen.
	public static let ShowMobileIntro = AddToListScreen(rawValue: 1 << 3)

	/// ID intro screen.
	public static let ShowIDIntro = AddToListScreen(rawValue: 1 << 4)

	internal var stringRepresentation: String {

			if self == AddToListScreen.ShowMobileIntro {

			return Constants.Value.MOBILE
		}
		else  if self == AddToListScreen.ShowIDIntro {

			return Constants.Value.ID
		}
		else {

			return String.tap_empty
		}
	}
}
