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
public class LinkEmailRequirement: Enum {

	public static let SendOnlyReceiptByMail = LinkEmailRequirement(rawValue: 0)
	public static let SendReceiptAndLinkEmail = LinkEmailRequirement(rawValue: 1)
	public static let VerifyEmail = LinkEmailRequirement(rawValue: 2)

	/// Returns string representation of the receiver.
	internal var stringRepresentation: String {

			if self == LinkEmailRequirement.SendOnlyReceiptByMail {

			return Constants.Value.R
		}
		else  if self == LinkEmailRequirement.SendReceiptAndLinkEmail {

			return Constants.Value.L
		}
		else  if self == LinkEmailRequirement.VerifyEmail {

			return Constants.Value.V
		}

		return String.tap_empty
	}

	/**
	 Initializes from string value.

	 - parameter stringValue: Enum's string representation.

	 - returns: Enum value.
	 */
	internal static func with(stringValue: String?) -> LinkEmailRequirement {

		guard let string = stringValue else {

			return LinkEmailRequirement.SendOnlyReceiptByMail
		}

		switch string {

			case Constants.Value.R:

				return LinkEmailRequirement.SendOnlyReceiptByMail

			case Constants.Value.L:

				return LinkEmailRequirement.SendReceiptAndLinkEmail

			case Constants.Value.V:

				return LinkEmailRequirement.VerifyEmail

			default:

				return LinkEmailRequirement.SendOnlyReceiptByMail
		}
	}
}
