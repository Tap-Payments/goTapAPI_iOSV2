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
public class ItemRowType: Enum {

	public static let None = ItemRowType(rawValue: 0)
	public static let Paid = ItemRowType(rawValue: 1)

	/// Returns string representation of the receiver.
	internal var stringRepresentation: String {

			if self == ItemRowType.Paid {

			return Constants.Value.PAID
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
	internal static func with(stringValue string: String?) -> ItemRowType {

		guard string != nil else {

			return ItemRowType.None
		}

		switch string! {

		case Constants.Value.PAID:

			return ItemRowType.Paid

		default:

			return ItemRowType.None
		}
	}
}
