//
//  TransactionCard.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Transaction card data model.
public class TransactionCard: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Card ID.
	public private(set) var cardID: String = String.tap_empty

	/// Card number.
	public private(set) var cardNumber: String = String.tap_empty

	/// Gateway ID.
	public private(set) var gatewayID: Int64 = 0

	/// Expiration date.
	public private(set) var expirationDate: String = String.tap_empty

	/// CVV code.
	public private(set) var cvv: String = String.tap_empty

	/// Name on card.
	public private(set) var nameOnCard: String = String.tap_empty

	/// Card type.
	public private(set) var cardType: goTapAPI.CardType = goTapAPI.CardType.Debit

	internal override var serializedModel: AnyObject? {

		let result: [String: Any] = [

			goTapAPI.Constants.Key.CardID: cardID,
			goTapAPI.Constants.Key.CardNmbr: cardNumber,
			goTapAPI.Constants.Key.GateWayID: gatewayID,
			goTapAPI.Constants.Key.ExpiryDate: expirationDate,
			goTapAPI.Constants.Key.CVV: cvv,
			goTapAPI.Constants.Key.NameonCard: nameOnCard,
			goTapAPI.Constants.Key.CardType: cardType.stringRepresentation
		]

		return result as AnyObject
	}

	//MARK: Methods

	public required init() { super.init() }

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.TransactionCard else { return nil }

		guard let parsedCardID = dictionary.parseString(forKey: goTapAPI.Constants.Key.CardID) else { return nil }
		guard let parsedCardNumber = dictionary.parseString(forKey: goTapAPI.Constants.Key.CardNmbr) else { return nil }
		guard let parsedGatewayID = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.GateWayID) else { return nil }
		guard let parsedExpirationDate = dictionary.parseString(forKey: goTapAPI.Constants.Key.ExpiryDate) else { return nil }
		guard let parsedCVV = dictionary.parseString(forKey: goTapAPI.Constants.Key.CVV) else { return nil }
		guard let parsedNameOnCard = dictionary.parseString(forKey: goTapAPI.Constants.Key.NameonCard) else { return nil }
		guard let parsedCardType = goTapAPI.CardType.with(stringValue: dictionary.parseString(forKey: goTapAPI.Constants.Key.CardType)) else { return nil }

		model.cardID = parsedCardID
		model.cardNumber = parsedCardNumber
		model.gatewayID = parsedGatewayID
		model.expirationDate = parsedExpirationDate
		model.cvv = parsedCVV
		model.nameOnCard = parsedNameOnCard
		model.cardType = parsedCardType

		return model.tap_asSelf()
	}

	/**
	 Initializes card with all the fields.

	 - parameter cardID:         Card ID.
	 - parameter cardNumber:     Card number.
	 - parameter gatewayID:      Gateway ID.
	 - parameter expirationDate: Expiration date.
	 - parameter cvv:            CVV code.
	 - parameter nameOnCard:     Name on card.
	 - parameter cardType:       Card type.

	 - returns: Returns new instance of TPAPITransactionCard.
	 */
	internal init(cardID: String, cardNumber: String, gatewayID: Int64, expirationDate: String, cvv: String, nameOnCard: String, cardType: goTapAPI.CardType) {

		super.init()

		self.cardID = cardID
		self.cardNumber = cardNumber
		self.gatewayID = gatewayID
		self.expirationDate = expirationDate
		self.cvv = cvv
		self.nameOnCard = nameOnCard
		self.cardType = cardType
	}

	/**
	 Updates card fields.

	 - parameter cardNumber:     New card number.
	 - parameter expirationDate: New expiration date.
	 - parameter cvv:            New CVV.
	 - parameter nameOnCard:     New name on card.
	 */
	public func updateWith(_ cardNumber: String, expirationDate: String, cvv: String, nameOnCard: String) {

		self.cardNumber = cardNumber
		self.expirationDate = expirationDate
		self.cvv = cvv
		self.nameOnCard = nameOnCard
	}
}
