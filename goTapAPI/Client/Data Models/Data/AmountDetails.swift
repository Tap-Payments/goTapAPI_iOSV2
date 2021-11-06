//
//  TPAPIAmountDetails.swift
//  goTap
//
//  Created by Dennis Pashkov on 2/14/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Amount details.
public class AmountDetails: DataModel {
	
	//MARK: - Public -
	//MARK: Properties
	
	/// Currency code.
	public private(set) var currencyCode: String?
	
	/// Currency symbol.
	public private(set) var currencySymbol: String?
	
	/// Payment currency code.
	public private(set) var paymentCurrencyCode: String?
	
	/// Payment currency symbol.
	public private(set) var paymentCurrencySymbol: String?
	
	/// Payment transaction amount.
	public private(set) var paymentTransactionAmount: Foundation.Decimal = Foundation.Decimal.zero
	
	/// Tips amount.
	public private(set) var tipAmount: Foundation.Decimal = Foundation.Decimal.zero
	
	/// Transaction amount.
	public private(set) var transactionAmount: Foundation.Decimal = Foundation.Decimal.zero
	
	/// Transaction ID.
	public private(set) var transactionID: String?
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? AmountDetails else { return nil }
		
		model.currencyCode = dictionary.parseString(forKey: Constants.Key.CurrencyCD)
		model.currencySymbol = dictionary.parseString(forKey: Constants.Key.CurrencySymbol)
		model.paymentCurrencyCode = dictionary.parseString(forKey: Constants.Key.PayCurrencyCD)
		model.paymentCurrencySymbol = dictionary.parseString(forKey: Constants.Key.PayCurrencySymbol)
		model.paymentTransactionAmount = dictionary.parseAmount(forKey: Constants.Key.PayTxnAmount) ?? Foundation.Decimal.zero
		model.tipAmount = dictionary.parseAmount(forKey: Constants.Key.TipAmount) ?? Foundation.Decimal.zero
		model.transactionAmount = dictionary.parseAmount(forKey: Constants.Key.TxnAmount) ?? Foundation.Decimal.zero
		model.transactionID = dictionary.parseString(forKey: Constants.Key.TxnID)
		
		return model.tap_asSelf()
	}
}
