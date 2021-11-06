//
//  CardType.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 11/30/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/**
 *  Card type enum.
 */
 public class CardType: Enum {

	 public static let Debit = CardType(rawValue: 0)
	 public static let Credit = CardType(rawValue: 1)
	 public static let Telecom = CardType(rawValue: 2)

	 /// Returns string representation of the receiver.
	 internal var stringRepresentation: String {

		 if self == CardType.Debit {

			 return Constants.Value.DEBIT
		 }
		 else if self == CardType.Credit {

			 return Constants.Value.CREDIT
		 }
		 else if self == CardType.Telecom {

			 return Constants.Value.TELECOM
		 }
		 else {

			 return String.tap_empty
		 }
	 }

	 /**
	 Initializes enum from string.

	 - parameter string: String representation of enum.

	 - returns: CardType.
	 */
	 internal static func with(stringValue: String?) -> CardType? {

		 guard let string = stringValue else {

			 return nil
		 }

		 switch string {

			case Constants.Value.DEBIT:

				return CardType.Debit

			case Constants.Value.CREDIT:

				return CardType.Credit

			case Constants.Value.TELECOM:

				return CardType.Telecom

			default:

				return nil
		 }
	 }
}
