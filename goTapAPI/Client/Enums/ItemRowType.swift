//
//  ItemRowType.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/9/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 Item row type enum.

 - None:             None. Default value.
 - Paid:             Paid.
 */
public class ItemRowType: goTapAPI.Enum {

	public static let None = goTapAPI.ItemRowType(rawValue: 0)
	public static let Paid = goTapAPI.ItemRowType(rawValue: 1)

	/// Returns string representation of the receiver.
	internal var stringRepresentation: String {

			if self == ItemRowType.Paid {

			return goTapAPI.Constants.Value.PAID
		}
		else {

			return String.tap_empty
		}
	}

	/**
	 Initializes enum from its string representation.

	 - parameter string: String representation.

	 - returns: TPAPIItemRowType
	 */
	internal static func with(stringValue string: String?) -> goTapAPI.ItemRowType {

		guard string != nil else {

			return goTapAPI.ItemRowType.None
		}

		switch string! {

		case goTapAPI.Constants.Value.PAID:

			return goTapAPI.ItemRowType.Paid

		default:

			return goTapAPI.ItemRowType.None
		}
	}
}
