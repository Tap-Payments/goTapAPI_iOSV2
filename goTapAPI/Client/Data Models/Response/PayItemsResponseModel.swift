//
//  PayItemsResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/14/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Pay items response model.
public class PayItemsResponseModel: goTapAPI.ResponseModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Amount details.
	public private(set) var amountDetails: goTapAPI.AmountDetails!
	
	/// Payment cards.
	public private(set) var paymentCards: [goTapAPI.PaymentCard]!
	
	/// Transaction charges.
	public private(set) var transactionCharges: [goTapAPI.TransactionCharge]!
	
	/// Transaction ID.
	public private(set) var transactionID: String!
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.PayItemsResponseModel else { return nil }
		
		guard let nonnullAmountDetails = goTapAPI.AmountDetails().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: goTapAPI.Constants.Key.AmountDetails) as AnyObject) else { return nil }
		model.amountDetails = nonnullAmountDetails
		
		let paymentCardParsingClosure: (AnyObject) -> goTapAPI.PaymentCard? = { object in
		
			return goTapAPI.PaymentCard().dataModelWith(serializedObject: object)
		}
		
		guard let parsedPaymentCards = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.PaymentCards), usingClosure: paymentCardParsingClosure) else { return nil }
		
		model.paymentCards = parsedPaymentCards
		
		let transactionChargeParsingClosure: (AnyObject) -> goTapAPI.TransactionCharge? = { object in
		
			return goTapAPI.TransactionCharge().dataModelWith(serializedObject: object)
		}
		
		guard let parsedTransactionCharges = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.TXNCharges), usingClosure: transactionChargeParsingClosure) else { return nil }
		model.transactionCharges =  parsedTransactionCharges
		
		guard let nonnullTransactionID = dictionary.parseString(forKey: goTapAPI.Constants.Key.TxnID) else { return nil }
		model.transactionID = nonnullTransactionID 
		
		return model.tap_asSelf()
	}
}
