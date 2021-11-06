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
public class ItemType: Enum {

	public static let Bill = ItemType(rawValue: 0)
	public static let Donation = ItemType(rawValue: 1)
	public static let Invoice = ItemType(rawValue: 2)
	public static let Membership = ItemType(rawValue: 3)
	public static let PrepaidCard = ItemType(rawValue: 4)
	public static let Product = ItemType(rawValue: 5)
	public static let Rent = ItemType(rawValue: 6)
	public static let Subscription = ItemType(rawValue: 7)
	public static let Ticket = ItemType(rawValue: 8)
	public static let Topup = ItemType(rawValue: 9)

	public static let Static = ItemType(rawValue: 10)
	public static let Interactive = ItemType(rawValue: 11)

	public var readableValue: String {

		let dataSource = Client.sharedInstance.dataSource!

			if self == ItemType.Bill {

			return dataSource.localizedString(forKey: Constants.Key.Localization.ItemType.Bill)
		}
		else  if self == ItemType.Donation {

			return dataSource.localizedString(forKey: Constants.Key.Localization.ItemType.Donation)
		}
		else  if self == ItemType.Invoice {

			return dataSource.localizedString(forKey: Constants.Key.Localization.ItemType.Invoice)
		}
		else  if self == ItemType.Membership {

			return dataSource.localizedString(forKey: Constants.Key.Localization.ItemType.Membership)
		}
		else  if self == ItemType.PrepaidCard {

			return dataSource.localizedString(forKey: Constants.Key.Localization.ItemType.Prepaid_card)
		}
		else  if self == ItemType.Product {

			return dataSource.localizedString(forKey: Constants.Key.Localization.ItemType.Product)
		}
		else  if self == ItemType.Rent {

			return dataSource.localizedString(forKey: Constants.Key.Localization.ItemType.Rent)
		}
		else  if self == ItemType.Subscription {

			return dataSource.localizedString(forKey: Constants.Key.Localization.ItemType.Subscription)
		}
		else  if self == ItemType.Ticket {

			return dataSource.localizedString(forKey: Constants.Key.Localization.ItemType.Ticket)
		}
		else  if self == ItemType.Topup {

			return dataSource.localizedString(forKey: Constants.Key.Localization.ItemType.Topup)
		}

		return String.tap_empty
	}

	/// Returns string representation of the receiver.
	public var stringRepresentation: String {

			if self == ItemType.Bill {

			return Constants.Value.BILL
		}
		else  if self == ItemType.Donation {

			return Constants.Value.DONATION
		}
		else  if self == ItemType.Invoice {

			return Constants.Value.INVOICE
		}
		else  if self == ItemType.Membership {

			return Constants.Value.MEMBERSHIP
		}
		else  if self == ItemType.PrepaidCard {

			return Constants.Value.PREPAIDCARD
		}
		else  if self == ItemType.Product {

			return Constants.Value.PRODUCT
		}
		else  if self == ItemType.Rent {

			return Constants.Value.RENT
		}
		else  if self == ItemType.Subscription {

			return Constants.Value.SUBS
		}
		else  if self == ItemType.Ticket {

			return Constants.Value.TICKET
		}
		else  if self == ItemType.Topup {

			return Constants.Value.TOPUP
		}
		else  if self == ItemType.Static {

			return Constants.Value.STATIC
		}
		else  if self == ItemType.Interactive {

			return Constants.Value.INTERACTIVE
		}

		return Constants.Value.BILL
	}

	/**
	 Initializes enum from string.

	 - parameter string: String representation of enum value.

	 - returns: TPAPIItemType.
	 */
	internal static func with(stringValue string: String?) -> ItemType {

		guard string != nil else {

			return ItemType.Static
		}

		switch string! {

		case Constants.Value.BILL:

			return ItemType.Bill

		case Constants.Value.DONATION:

			return ItemType.Donation

		case Constants.Value.INVOICE:

			return ItemType.Invoice

		case Constants.Value.MEMBERSHIP:

			return ItemType.Membership

		case Constants.Value.PREPAIDCARD:

			return ItemType.PrepaidCard

		case Constants.Value.PRODUCT:

			return ItemType.Product

		case Constants.Value.RENT:

			return ItemType.Rent

		case Constants.Value.SUBS:

			return ItemType.Subscription

		case Constants.Value.TICKET:

			return ItemType.Ticket

		case Constants.Value.TOPUP:

			return ItemType.Topup

		case Constants.Value.STATIC:

			return ItemType.Static

		case Constants.Value.INTERACTIVE:

			return ItemType.Interactive

		default:

			return ItemType.Static
		}
	}
}
