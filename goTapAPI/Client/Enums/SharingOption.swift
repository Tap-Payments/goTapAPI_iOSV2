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
public class SharingOption: goTapAPI.Enum {

	public static let SMS = goTapAPI.SharingOption(rawValue: 1)
	public static let Mail = goTapAPI.SharingOption(rawValue: 2)
	public static let Facebook = goTapAPI.SharingOption(rawValue: 3)
	public static let FacebookMessenger = goTapAPI.SharingOption(rawValue: 4)
	public static let Twitter = goTapAPI.SharingOption(rawValue: 5)
	public static let WhatsApp = goTapAPI.SharingOption(rawValue: 6)
	public static let Instagram = goTapAPI.SharingOption(rawValue: 7)
	public static let Linkedin = goTapAPI.SharingOption(rawValue: 8)
	public static let GooglePlus = goTapAPI.SharingOption(rawValue: 9)

	/// Returns string representation of the receiver.
	public var stringRepresentation: String {

			if self == SharingOption.SMS {

			return goTapAPI.Constants.Value.SMS
		}
		else  if self == SharingOption.Mail {

			return goTapAPI.Constants.Value.Mail
		}
		else  if self == SharingOption.Facebook {

			return goTapAPI.Constants.Value.Facebook
		}
		else  if self == SharingOption.FacebookMessenger {

			return goTapAPI.Constants.Value.FacebookMessenger
		}
		else  if self == SharingOption.Twitter {

			return goTapAPI.Constants.Value.Twitter
		}
		else  if self == SharingOption.WhatsApp {

			return goTapAPI.Constants.Value.Whatsapp
		}
		else  if self == SharingOption.Instagram {

			return goTapAPI.Constants.Value.Instagram
		}
		else  if self == SharingOption.Linkedin {

			return goTapAPI.Constants.Value.Linkedin
		}
		else  if self == SharingOption.GooglePlus {

			return goTapAPI.Constants.Value.GooglePlus
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
	internal static func with(stringValue: String?) -> goTapAPI.SharingOption {

		guard let string = stringValue else {

			return goTapAPI.SharingOption.Mail
		}

		switch string {

			case goTapAPI.Constants.Value.SMS:

				return goTapAPI.SharingOption.SMS

			case goTapAPI.Constants.Value.Mail:

				return goTapAPI.SharingOption.Mail

			case goTapAPI.Constants.Value.Facebook:

				return goTapAPI.SharingOption.Facebook

			case goTapAPI.Constants.Value.FacebookMessenger:

				return goTapAPI.SharingOption.FacebookMessenger

			case goTapAPI.Constants.Value.Twitter:

				return goTapAPI.SharingOption.Twitter

			case goTapAPI.Constants.Value.Whatsapp:

				return goTapAPI.SharingOption.WhatsApp

			case goTapAPI.Constants.Value.Instagram:

				return goTapAPI.SharingOption.Instagram

			case goTapAPI.Constants.Value.Linkedin:

				return goTapAPI.SharingOption.Linkedin

			case goTapAPI.Constants.Value.GooglePlus:

				return goTapAPI.SharingOption.GooglePlus

			default:

				return goTapAPI.SharingOption.Mail
		}
	}
}
