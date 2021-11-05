//
//  QuickAddListInputData.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 Input data type for quick add list API.

 - Mobile: Mobile.
 - ID:     ID.
 - ScanID: Scan ID.
 */
internal class QuickAddListInputData: goTapAPI.Enum {

	internal static let Mobile = goTapAPI.QuickAddListInputData(rawValue: 0)
	internal static let ID = goTapAPI.QuickAddListInputData(rawValue: 1)
	internal static let ScanID = goTapAPI.QuickAddListInputData(rawValue: 2)

	/// Returns string representation of the receiver.
	var stringRepresentation: String {

		if self == goTapAPI.QuickAddListInputData.Mobile {

			return goTapAPI.Constants.Value.MOBILE
		}
		else if self == goTapAPI.QuickAddListInputData.ID {

			return goTapAPI.Constants.Value.ID
		}
		else if self == goTapAPI.QuickAddListInputData.ScanID {

			return goTapAPI.Constants.Value.SCAN_ID
		}

		return String.tap_empty
	}
}
