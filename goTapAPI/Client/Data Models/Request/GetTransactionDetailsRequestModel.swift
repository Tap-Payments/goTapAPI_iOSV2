//
//  GetTransactionDetailsRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model to get transaction details.
internal class GetTransactionDetailsRequestModel: goTapAPI.RequestModel {

	//MARK: - Public -
	//MARK: Properties

	internal private(set) var transactionID: String = String.tap_empty

	internal override var serializedModel: AnyObject? {

		let result: [String: Any] = [

			goTapAPI.Constants.Key.TxnID: transactionID
		]

		return result as AnyObject
	}

	//MARK: Methods

	/**
	 Initializes data model with transaction ID.

	 - parameter transactionID: Transaction ID.

	 - returns: TPAPIGetTransactionDetailsRequestModel
	 */
	internal init(transactionID: String) {

		super.init()
		self.transactionID = transactionID
	}

	public required init() { super.init() }
}
