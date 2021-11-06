//
//  PayTransactionResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/13/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Pay transaction response model.
public class PayTransactionResponseModel: ResponseModel {

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
	public private(set) var responseCode: TransactionResponseType = TransactionResponseType.Other

	/// Response message.
	public private(set) var responseMessage: String = String.tap_empty

	/// Receipt details.
	public private(set) var receiptDetails: ReceiptDetails = ReceiptDetails()

	/// Transaction URL.
	public private(set) var transactionURL: URL?

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? PayTransactionResponseModel else { return nil }

		guard let parsedTransactionID = dictionary.parseString(forKey: Constants.Key.TxnID) else { return nil }
		guard let parsedAmount = dictionary.parseAmount(forKey: Constants.Key.Amount) else { return nil }
		guard let parsedCurrencySymbol = dictionary.parseString(forKey: Constants.Key.CurrencySymbol) else { return nil }
		guard let parsedResponseCode = dictionary.parseInteger(forKey: Constants.Key.ResponseCode) else { return nil }
		guard let parsedResponseMessage = dictionary.parseString(forKey: Constants.Key.ResponseMsg) else { return nil }
		guard let parsedReceiptDetails = ReceiptDetails().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: Constants.Key.ReceiptDetails) as AnyObject) else { return nil }

		model.transactionID = parsedTransactionID
		model.amount = parsedAmount
		model.currencyCode = dictionary.parseString(forKey: Constants.Key.CurrencyCode)
		model.currencySymbol = parsedCurrencySymbol
		model.responseCode = TransactionResponseType.with(intValue: parsedResponseCode)
		model.responseMessage = parsedResponseMessage
		model.receiptDetails = parsedReceiptDetails
		model.transactionURL = dictionary.parseURL(forKey: Constants.Key.TxnURL)

		return model.tap_asSelf()
	}
}
