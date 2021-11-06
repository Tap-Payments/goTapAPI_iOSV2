//
//  SharingOption.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/28/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 Sharing option enum.

 - SMS:               SMS.
 - Mail:              Email.
 - Facebook:          Facebook.
 - FacebookMessenger: Facebook Messenger.
 - Twitter:           Twitter.
 - WhatsApp:          WhatsApp.
 - Instagram:         Instagram.
 - Linkedin:          LinkedIn.
 - GooglePlus:        Google Plus.
 */
public class SharingOption: Enum {

	public static let SMS = SharingOption(rawValue: 1)
	public static let Mail = SharingOption(rawValue: 2)
	public static let Facebook = SharingOption(rawValue: 3)
	public static let FacebookMessenger = SharingOption(rawValue: 4)
	public static let Twitter = SharingOption(rawValue: 5)
	public static let WhatsApp = SharingOption(rawValue: 6)
	public static let Instagram = SharingOption(rawValue: 7)
	public static let Linkedin = SharingOption(rawValue: 8)
	public static let GooglePlus = SharingOption(rawValue: 9)

	/// Returns string representation of the receiver.
	public var stringRepresentation: String {

			if self == SharingOption.SMS {

			return Constants.Value.SMS
		}
		else  if self == SharingOption.Mail {

			return Constants.Value.Mail
		}
		else  if self == SharingOption.Facebook {

			return Constants.Value.Facebook
		}
		else  if self == SharingOption.FacebookMessenger {

			return Constants.Value.FacebookMessenger
		}
		else  if self == SharingOption.Twitter {

			return Constants.Value.Twitter
		}
		else  if self == SharingOption.WhatsApp {

			return Constants.Value.Whatsapp
		}
		else  if self == SharingOption.Instagram {

			return Constants.Value.Instagram
		}
		else  if self == SharingOption.Linkedin {

			return Constants.Value.Linkedin
		}
		else  if self == SharingOption.GooglePlus {

			return Constants.Value.GooglePlus
		}
		else {

			return String.tap_empty
		}
	}

	/**
	 Initializes sharing option with medium string.

	 - parameter mediumString: Medium string.

	 - returns: Sharing option created with a medium string.
	 */
	internal static func with(stringValue: String?) -> SharingOption {

		guard let string = stringValue else {

			return SharingOption.Mail
		}

		switch string {

			case Constants.Value.SMS:

				return SharingOption.SMS

			case Constants.Value.Mail:

				return SharingOption.Mail

			case Constants.Value.Facebook:

				return SharingOption.Facebook

			case Constants.Value.FacebookMessenger:

				return SharingOption.FacebookMessenger

			case Constants.Value.Twitter:

				return SharingOption.Twitter

			case Constants.Value.Whatsapp:

				return SharingOption.WhatsApp

			case Constants.Value.Instagram:

				return SharingOption.Instagram

			case Constants.Value.Linkedin:

				return SharingOption.Linkedin

			case Constants.Value.GooglePlus:

				return SharingOption.GooglePlus

			default:

				return SharingOption.Mail
		}
	}
}
