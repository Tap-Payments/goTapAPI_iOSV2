//
//  TPAPIItemType.swift
//  goTap
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 Item type enum.

 - Bill:         Bill.
 - Donation:     Donation.
 - Invoice:      Invoice.
 - Membership:   Membership.
 - PrepaidCard:  Prepaid card.
 - Product:      Product.
 - Rent:         Rent.
 - Subscription: Subscription.
 - Ticket:       Ticket
 - Topup:        Topup.
 - Static:       Static item.
 - Interactive:  Interactive item.
 */
public class ItemType: goTapAPI.Enum {

	public static let Bill = goTapAPI.ItemType(rawValue: 0)
	public static let Donation = goTapAPI.ItemType(rawValue: 1)
	public static let Invoice = goTapAPI.ItemType(rawValue: 2)
	public static let Membership = goTapAPI.ItemType(rawValue: 3)
	public static let PrepaidCard = goTapAPI.ItemType(rawValue: 4)
	public static let Product = goTapAPI.ItemType(rawValue: 5)
	public static let Rent = goTapAPI.ItemType(rawValue: 6)
	public static let Subscription = goTapAPI.ItemType(rawValue: 7)
	public static let Ticket = goTapAPI.ItemType(rawValue: 8)
	public static let Topup = goTapAPI.ItemType(rawValue: 9)

	public static let Static = goTapAPI.ItemType(rawValue: 10)
	public static let Interactive = goTapAPI.ItemType(rawValue: 11)

	public var readableValue: String {

		let dataSource = goTapAPI.Client.sharedInstance.dataSource!

			if self == ItemType.Bill {

			return dataSource.localizedString(forKey: goTapAPI.Constants.Key.Localization.ItemType.Bill)
		}
		else  if self == ItemType.Donation {

			return dataSource.localizedString(forKey: goTapAPI.Constants.Key.Localization.ItemType.Donation)
		}
		else  if self == ItemType.Invoice {

			return dataSource.localizedString(forKey: goTapAPI.Constants.Key.Localization.ItemType.Invoice)
		}
		else  if self == ItemType.Membership {

			return dataSource.localizedString(forKey: goTapAPI.Constants.Key.Localization.ItemType.Membership)
		}
		else  if self == ItemType.PrepaidCard {

			return dataSource.localizedString(forKey: goTapAPI.Constants.Key.Localization.ItemType.Prepaid_card)
		}
		else  if self == ItemType.Product {

			return dataSource.localizedString(forKey: goTapAPI.Constants.Key.Localization.ItemType.Product)
		}
		else  if self == ItemType.Rent {

			return dataSource.localizedString(forKey: goTapAPI.Constants.Key.Localization.ItemType.Rent)
		}
		else  if self == ItemType.Subscription {

			return dataSource.localizedString(forKey: goTapAPI.Constants.Key.Localization.ItemType.Subscription)
		}
		else  if self == ItemType.Ticket {

			return dataSource.localizedString(forKey: goTapAPI.Constants.Key.Localization.ItemType.Ticket)
		}
		else  if self == ItemType.Topup {

			return dataSource.localizedString(forKey: goTapAPI.Constants.Key.Localization.ItemType.Topup)
		}

		return String.tap_empty
	}

	/// Returns string representation of the receiver.
	public var stringRepresentation: String {

			if self == ItemType.Bill {

			return goTapAPI.Constants.Value.BILL
		}
		else  if self == ItemType.Donation {

			return goTapAPI.Constants.Value.DONATION
		}
		else  if self == ItemType.Invoice {

			return goTapAPI.Constants.Value.INVOICE
		}
		else  if self == ItemType.Membership {

			return goTapAPI.Constants.Value.MEMBERSHIP
		}
		else  if self == ItemType.PrepaidCard {

			return goTapAPI.Constants.Value.PREPAIDCARD
		}
		else  if self == ItemType.Product {

			return goTapAPI.Constants.Value.PRODUCT
		}
		else  if self == ItemType.Rent {

			return goTapAPI.Constants.Value.RENT
		}
		else  if self == ItemType.Subscription {

			return goTapAPI.Constants.Value.SUBS
		}
		else  if self == ItemType.Ticket {

			return goTapAPI.Constants.Value.TICKET
		}
		else  if self == ItemType.Topup {

			return goTapAPI.Constants.Value.TOPUP
		}
		else  if self == ItemType.Static {

			return goTapAPI.Constants.Value.STATIC
		}
		else  if self == ItemType.Interactive {

			return goTapAPI.Constants.Value.INTERACTIVE
		}

		return goTapAPI.Constants.Value.BILL
	}

	/**
	 Initializes enum from string.

	 - parameter string: String representation of enum value.

	 - returns: TPAPIItemType.
	 */
	internal static func with(stringValue string: String?) -> goTapAPI.ItemType {

		guard string != nil else {

			return goTapAPI.ItemType.Static
		}

		switch string! {

		case goTapAPI.Constants.Value.BILL:

			return goTapAPI.ItemType.Bill

		case goTapAPI.Constants.Value.DONATION:

			return goTapAPI.ItemType.Donation

		case goTapAPI.Constants.Value.INVOICE:

			return goTapAPI.ItemType.Invoice

		case goTapAPI.Constants.Value.MEMBERSHIP:

			return goTapAPI.ItemType.Membership

		case goTapAPI.Constants.Value.PREPAIDCARD:

			return goTapAPI.ItemType.PrepaidCard

		case goTapAPI.Constants.Value.PRODUCT:

			return goTapAPI.ItemType.Product

		case goTapAPI.Constants.Value.RENT:

			return goTapAPI.ItemType.Rent

		case goTapAPI.Constants.Value.SUBS:

			return goTapAPI.ItemType.Subscription

		case goTapAPI.Constants.Value.TICKET:

			return goTapAPI.ItemType.Ticket

		case goTapAPI.Constants.Value.TOPUP:

			return goTapAPI.ItemType.Topup

		case goTapAPI.Constants.Value.STATIC:

			return goTapAPI.ItemType.Static

		case goTapAPI.Constants.Value.INTERACTIVE:

			return goTapAPI.ItemType.Interactive

		default:

			return goTapAPI.ItemType.Static
		}
	}
}
