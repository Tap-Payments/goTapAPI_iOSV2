//
//  PayTransactionResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/13/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Pay transaction response model.
public class PayTransactionResponseModel: goTapAPI.ResponseModel {

	//MARK: - Public -
	//MARK: Properties

	/// Transaction ID.
	public private(set) var transactionID: String = String.tap_empty

	/// Amount.
	public private(set) var amount: Foundation.Decimal = Foundation.Decimal.zero

	/// Currency code.
	public private(set) var currencyCode: String?

	/// Currency symbol.
	public private(set) var currencySymbol: String = String.tap_empty

	/// Response code.
	public private(set) var responseCode: goTapAPI.TransactionResponseType = goTapAPI.TransactionResponseType.Other

	/// Response message.
	public private(set) var responseMessage: String = String.tap_empty

	/// Receipt details.
	public private(set) var receiptDetails: goTapAPI.ReceiptDetails = goTapAPI.ReceiptDetails()

	/// Transaction URL.
	public private(set) var transactionURL: URL?

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.PayTransactionResponseModel else { return nil }

		guard let parsedTransactionID = dictionary.parseString(forKey: goTapAPI.Constants.Key.TxnID) else { return nil }
		guard let parsedAmount = dictionary.parseAmount(forKey: goTapAPI.Constants.Key.Amount) else { return nil }
		guard let parsedCurrencySymbol = dictionary.parseString(forKey: goTapAPI.Constants.Key.CurrencySymbol) else { return nil }
		guard let parsedResponseCode = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.ResponseCode) else { return nil }
		guard let parsedResponseMessage = dictionary.parseString(forKey: goTapAPI.Constants.Key.ResponseMsg) else { return nil }
		guard let parsedReceiptDetails = goTapAPI.ReceiptDetails().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: goTapAPI.Constants.Key.ReceiptDetails) as AnyObject) else { return nil }

		model.transactionID = parsedTransactionID
		model.amount = parsedAmount
		model.currencyCode = dictionary.parseString(forKey: goTapAPI.Constants.Key.CurrencyCode)
		model.currencySymbol = parsedCurrencySymbol
		model.responseCode = goTapAPI.TransactionResponseType.with(intValue: parsedResponseCode)
		model.responseMessage = parsedResponseMessage
		model.receiptDetails = parsedReceiptDetails
		model.transactionURL = dictionary.parseURL(forKey: goTapAPI.Constants.Key.TxnURL)

		return model.tap_asSelf()
	}
}
