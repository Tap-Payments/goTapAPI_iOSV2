//
//  ItemAction.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 Item action enum.

 - None:   None action. Default value
 - New:    New item.
 - Update: Update item.
 - Delete: Delete item.
 */

public class ItemAction: Enum {

	public static let None = ItemAction(rawValue: 0)
	public static let New = ItemAction(rawValue: 1)
	public static let Update = ItemAction(rawValue: 2)
	public static let Delete = ItemAction(rawValue: 3)

	/// Returns string representation of the receiver.
	internal var stringRepresentation: String {

			if self == ItemAction.None {

			return String.tap_empty
		}
		else  if self == ItemAction.New {

			return Constants.Value.NEW
		}
		else  if self == ItemAction.Update {

			return Constants.Value.UPDATE
		}
		else  if self == ItemAction.Delete {

			return Constants.Value.DELETE
		}

		return String.tap_empty
	}

	internal static func with(stringValue string: String?) -> ItemAction {

		guard string != nil else {

			return ItemAction.None
		}

		switch string! {

		case Constants.Value.NEW:

			return ItemAction.New

		case Constants.Value.UPDATE:

			return ItemAction.Update

		case Constants.Value.DELETE:

			return ItemAction.Delete

		default:

			return ItemAction.None
		}
	}
}
