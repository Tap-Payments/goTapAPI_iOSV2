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

public class ItemAction: goTapAPI.Enum {

	public static let None = goTapAPI.ItemAction(rawValue: 0)
	public static let New = goTapAPI.ItemAction(rawValue: 1)
	public static let Update = goTapAPI.ItemAction(rawValue: 2)
	public static let Delete = goTapAPI.ItemAction(rawValue: 3)

	/// Returns string representation of the receiver.
	internal var stringRepresentation: String {

			if self == ItemAction.None {

			return String.tap_empty
		}
		else  if self == ItemAction.New {

			return goTapAPI.Constants.Value.NEW
		}
		else  if self == ItemAction.Update {

			return goTapAPI.Constants.Value.UPDATE
		}
		else  if self == ItemAction.Delete {

			return goTapAPI.Constants.Value.DELETE
		}

		return String.tap_empty
	}

	internal static func with(stringValue string: String?) -> goTapAPI.ItemAction {

		guard string != nil else {

			return goTapAPI.ItemAction.None
		}

		switch string! {

		case goTapAPI.Constants.Value.NEW:

			return goTapAPI.ItemAction.New

		case goTapAPI.Constants.Value.UPDATE:

			return goTapAPI.ItemAction.Update

		case goTapAPI.Constants.Value.DELETE:

			return goTapAPI.ItemAction.Delete

		default:

			return goTapAPI.ItemAction.None
		}
	}
}
