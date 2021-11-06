//
//  TPAPITransactionAction.swift
//  goTap
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Transaction action data model.
public class TransactionAction: DataModel {

	//MARK: - Public
	//MARK: Properties
	
	/// Pay now.
	public private(set) var payNow: Swift.Bool = false
	
	/// Pay later.
	public private(set) var payLater: Swift.Bool = false
	
	/// Pay and collect.
	public private(set) var payAndCollect: Swift.Bool = false
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? TransactionAction else { return nil }
		
		model.payNow = dictionary.parseBoolean(forKey: Constants.Key.PayNow) ?? false
		model.payLater = dictionary.parseBoolean(forKey: Constants.Key.PayLater) ?? false
		model.payAndCollect = dictionary.parseBoolean(forKey: Constants.Key.PayAndCollect) ?? false
		
		return model.tap_asSelf()
	}
}
