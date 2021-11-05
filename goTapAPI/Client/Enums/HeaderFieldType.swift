//
//  HeaderFieldType.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/28/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 Enum for header field types.

 - Label:     Label field type.
 - TextField: Text field field type.
 - Dropdown:  Dropdown field type.
 */
public class HeaderFieldType: goTapAPI.Enum {

	public static let label = goTapAPI.HeaderFieldType(rawValue: 0)
	public static let textField = goTapAPI.HeaderFieldType(rawValue: 1)
	public static let dropdown = goTapAPI.HeaderFieldType(rawValue: 2)
	public static let addSchedule = goTapAPI.HeaderFieldType(rawValue: 3)
	public static let editSchedule = goTapAPI.HeaderFieldType(rawValue: 4)

	/// Returns string representation of the receiver.
	internal var stringRepresentation: String {

			if self == HeaderFieldType.label {

			return goTapAPI.Constants.Value.L
		}
		else  if self == HeaderFieldType.textField {

			return goTapAPI.Constants.Value.T
		}
		else  if self == HeaderFieldType.dropdown {

			return goTapAPI.Constants.Value.D
		}
		else  if self == HeaderFieldType.addSchedule {

			return goTapAPI.Constants.Value.A
		}
		else  if self == HeaderFieldType.editSchedule {

			return goTapAPI.Constants.Value.S
		}

		return goTapAPI.Constants.Value.L
	}

	internal static func with(stringValue: String?) -> goTapAPI.HeaderFieldType {

		guard let string = stringValue else {

			return goTapAPI.HeaderFieldType.label
		}

		switch string {

		case goTapAPI.Constants.Value.L:

			return goTapAPI.HeaderFieldType.label

		case goTapAPI.Constants.Value.T:

			return goTapAPI.HeaderFieldType.textField

		case goTapAPI.Constants.Value.D:

			return goTapAPI.HeaderFieldType.dropdown

		case goTapAPI.Constants.Value.A:

			return goTapAPI.HeaderFieldType.addSchedule

		case goTapAPI.Constants.Value.S:

			return goTapAPI.HeaderFieldType.editSchedule

		default:

			return goTapAPI.HeaderFieldType.label
		}
	}
}