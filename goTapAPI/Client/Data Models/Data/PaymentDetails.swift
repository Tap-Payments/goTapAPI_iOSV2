//
//  PaymentDetails.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Payment details data model.
internal class PaymentDetails: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Amount.
	internal private(set) var amount: Foundation.Decimal = Foundation.Decimal.zero

	/// Currency code.
	internal private(set) var currencyCode: String?

	/// Gateway ID.
	internal private(set) var gatewayID: Int64 = 0

	/// Transaction ID.
	internal private(set) var transactionID: String = String.tap_empty

	internal override var serializedModel: AnyObject? {

		var result: [String: Any] = [

			Constants.Key.Amount: self.amount,
			Constants.Key.GateWayID: self.gatewayID,
			Constants.Key.TxnID: self.transactionID
		]

		result[Constants.Key.CurrencyCode] = currencyCode ?? NSNull()

		return result as AnyObject
	}

	//MARK: Methods

	/**
	 Initializes data model with transaction ID.

	 - parameter transactionID: Transaction ID.

	 - returns: TPAPIPaymentDetails
	 */
	internal convenience init(transactionID: String) {

		self.init(transactionID: transactionID, amount: Foundation.Decimal.zero, gatewayID: 0, currencyCode: nil)
	}

	/**
	 Initializes data model with transaction ID, amount and currency code.

	 - parameter transactionID: Transaction ID.
	 - parameter amount:        Amount.
	 - parameter currencyCode:  Currency code.

	 - returns: TPAPIPaymentDetails.
	 */
	internal init(transactionID: String, amount: Foundation.Decimal, gatewayID: Int64, currencyCode: String? = nil) {

		super.init()

		self.transactionID = transactionID
		self.amount = amount
		self.gatewayID = gatewayID
		self.currencyCode = currencyCode
	}

	public required init() { super.init() }
}
