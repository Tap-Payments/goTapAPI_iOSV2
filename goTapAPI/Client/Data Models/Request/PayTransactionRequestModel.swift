//
//  PayTransactionRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for pay transaction request.
internal class PayTransactionRequestModel: goTapAPI.RequestModel {

	//MARK: - Public -
	//MARK: Properties

	/// Payment details.
	internal private(set) var paymentDetails: goTapAPI.PaymentDetails?

	/// Card info.
	internal private(set) var cardInfo: String = String.tap_empty

	internal override var serializedModel: AnyObject? {

		guard var result = super.serializedModel as? [String: Any] else { return nil }
		guard let appDataDictionary = goTapAPI.ApplicationData.sharedInstance.serializedModel as? [String: AnyObject] else { return nil }

		result[goTapAPI.Constants.Key.AuthType] = authType
		result[goTapAPI.Constants.Key.Password] = password ?? NSNull()
		result[goTapAPI.Constants.Key.PayDetails] = paymentDetails?.serializedModel ?? NSNull()
		result[goTapAPI.Constants.Key.CardInfo] = cardInfo
		result[goTapAPI.Constants.Key.AppData] = appDataDictionary

		return result as AnyObject
	}

	//MARK: Methods

	/**
	 Initializes data model with auth type, password, payment details and card info.

	 - parameter authType:       Auth type.
	 - parameter password:       Password.
	 - parameter paymentDetails: Payment details.
	 - parameter cardInfo:       Card info.

	 - returns: TPAPIPayTransactionRequestModel
	 */
	internal init(paymentDetails: goTapAPI.PaymentDetails?, cardInfo: String) {

		super.init()

		self.paymentDetails = paymentDetails
		self.cardInfo = cardInfo
	}

	//MARK: - Private -
	//MARK: Properties

	/// Auth type.
	private var authType: String = goTapAPI.Constants.Default.AuthType

	/// Password.
	private var password: String?

	public required init() { super.init() }
}
