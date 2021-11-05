//
//  LinkEmailRequirement.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 Requirement to link email.

 - SendOnlyReceiptByMail:   Only send receipt by mail.
 - SendReceiptAndLinkEmail: Send receipt and link email.
 - VerifyEmail:             Verify email.
 */
public class LinkEmailRequirement: goTapAPI.Enum {

	public static let SendOnlyReceiptByMail = goTapAPI.LinkEmailRequirement(rawValue: 0)
	public static let SendReceiptAndLinkEmail = goTapAPI.LinkEmailRequirement(rawValue: 1)
	public static let VerifyEmail = goTapAPI.LinkEmailRequirement(rawValue: 2)

	/// Returns string representation of the receiver.
	internal var stringRepresentation: String {

			if self == LinkEmailRequirement.SendOnlyReceiptByMail {

			return goTapAPI.Constants.Value.R
		}
		else  if self == LinkEmailRequirement.SendReceiptAndLinkEmail {

			return goTapAPI.Constants.Value.L
		}
		else  if self == LinkEmailRequirement.VerifyEmail {

			return goTapAPI.Constants.Value.V
		}

		return String.tap_empty
	}

	/**
	 Initializes from string value.

	 - parameter stringValue: Enum's string representation.

	 - returns: Enum value.
	 */
	internal static func with(stringValue: String?) -> goTapAPI.LinkEmailRequirement {

		guard let string = stringValue else {

			return goTapAPI.LinkEmailRequirement.SendOnlyReceiptByMail
		}

		switch string {

			case goTapAPI.Constants.Value.R:

				return goTapAPI.LinkEmailRequirement.SendOnlyReceiptByMail

			case goTapAPI.Constants.Value.L:

				return goTapAPI.LinkEmailRequirement.SendReceiptAndLinkEmail

			case goTapAPI.Constants.Value.V:

				return goTapAPI.LinkEmailRequirement.VerifyEmail

			default:

				return goTapAPI.LinkEmailRequirement.SendOnlyReceiptByMail
		}
	}
}
