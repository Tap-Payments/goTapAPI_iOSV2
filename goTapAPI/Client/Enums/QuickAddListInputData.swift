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
internal class QuickAddListInputData: Enum {

	internal static let Mobile = QuickAddListInputData(rawValue: 0)
	internal static let ID = QuickAddListInputData(rawValue: 1)
	internal static let ScanID = QuickAddListInputData(rawValue: 2)

	/// Returns string representation of the receiver.
	var stringRepresentation: String {

		if self == QuickAddListInputData.Mobile {

			return Constants.Value.MOBILE
		}
		else if self == QuickAddListInputData.ID {

			return Constants.Value.ID
		}
		else if self == QuickAddListInputData.ScanID {

			return Constants.Value.SCAN_ID
		}

		return String.tap_empty
	}
}
