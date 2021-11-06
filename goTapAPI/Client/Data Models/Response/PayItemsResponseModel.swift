//
//  PayItemsResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/14/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Pay items response model.
public class PayItemsResponseModel: ResponseModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Amount details.
	public private(set) var amountDetails: AmountDetails!
	
	/// Payment cards.
	public private(set) var paymentCards: [PaymentCard]!
	
	/// Transaction charges.
	public private(set) var transactionCharges: [TransactionCharge]!
	
	/// Transaction ID.
	public private(set) var transactionID: String!
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? PayItemsResponseModel else { return nil }
		
		guard let nonnullAmountDetails = AmountDetails().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: Constants.Key.AmountDetails) as AnyObject) else { return nil }
		model.amountDetails = nonnullAmountDetails
		
		let paymentCardParsingClosure: (AnyObject) -> PaymentCard? = { object in
		
			return PaymentCard().dataModelWith(serializedObject: object)
		}
		
		guard let parsedPaymentCards = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.PaymentCards), usingClosure: paymentCardParsingClosure) else { return nil }
		
		model.paymentCards = parsedPaymentCards
		
		let transactionChargeParsingClosure: (AnyObject) -> TransactionCharge? = { object in
		
			return TransactionCharge().dataModelWith(serializedObject: object)
		}
		
		guard let parsedTransactionCharges = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.TXNCharges), usingClosure: transactionChargeParsingClosure) else { return nil }
		model.transactionCharges =  parsedTransactionCharges
		
		guard let nonnullTransactionID = dictionary.parseString(forKey: Constants.Key.TxnID) else { return nil }
		model.transactionID = nonnullTransactionID 
		
		return model.tap_asSelf()
	}
}
