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
public class HeaderFieldType: Enum {

	public static let label = HeaderFieldType(rawValue: 0)
	public static let textField = HeaderFieldType(rawValue: 1)
	public static let dropdown = HeaderFieldType(rawValue: 2)
	public static let addSchedule = HeaderFieldType(rawValue: 3)
	public static let editSchedule = HeaderFieldType(rawValue: 4)

	/// Returns string representation of the receiver.
	internal var stringRepresentation: String {

			if self == HeaderFieldType.label {

			return Constants.Value.L
		}
		else  if self == HeaderFieldType.textField {

			return Constants.Value.T
		}
		else  if self == HeaderFieldType.dropdown {

			return Constants.Value.D
		}
		else  if self == HeaderFieldType.addSchedule {

			return Constants.Value.A
		}
		else  if self == HeaderFieldType.editSchedule {

			return Constants.Value.S
		}

		return Constants.Value.L
	}

	internal static func with(stringValue: String?) -> HeaderFieldType {

		guard let string = stringValue else {

			return HeaderFieldType.label
		}

		switch string {

		case Constants.Value.L:

			return HeaderFieldType.label

		case Constants.Value.T:

			return HeaderFieldType.textField

		case Constants.Value.D:

			return HeaderFieldType.dropdown

		case Constants.Value.A:

			return HeaderFieldType.addSchedule

		case Constants.Value.S:

			return HeaderFieldType.editSchedule

		default:

			return HeaderFieldType.label
		}
	}
}
