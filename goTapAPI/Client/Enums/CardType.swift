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
 public class CardType: goTapAPI.Enum {

	 public static let Debit = goTapAPI.CardType(rawValue: 0)
	 public static let Credit = goTapAPI.CardType(rawValue: 1)
	 public static let Telecom = goTapAPI.CardType(rawValue: 2)

	 /// Returns string representation of the receiver.
	 internal var stringRepresentation: String {

		 if self == goTapAPI.CardType.Debit {

			 return goTapAPI.Constants.Value.DEBIT
		 }
		 else if self == goTapAPI.CardType.Credit {

			 return goTapAPI.Constants.Value.CREDIT
		 }
		 else if self == goTapAPI.CardType.Telecom {

			 return goTapAPI.Constants.Value.TELECOM
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
	 internal static func with(stringValue: String?) -> goTapAPI.CardType? {

		 guard let string = stringValue else {

			 return nil
		 }

		 switch string {

			case goTapAPI.Constants.Value.DEBIT:

				return goTapAPI.CardType.Debit

			case goTapAPI.Constants.Value.CREDIT:

				return goTapAPI.CardType.Credit

			case goTapAPI.Constants.Value.TELECOM:

				return goTapAPI.CardType.Telecom

			default:

				return nil
		 }
	 }
}
