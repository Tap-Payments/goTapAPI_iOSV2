//
//  ShareAppRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for share app request.
internal class ShareAppRequestModel: RequestModel {

	//MARK: - Public -
	//MARK: Properties

	/// Transaction ID.
	internal private(set) var transactionID: String = String.tap_empty

	/// Medium.
	internal private(set) var medium: SharingOption = SharingOption.Mail

	/// Share action.
	internal private(set) var shareAction: SharingStatus = SharingStatus.Failed

	internal override var serializedModel: AnyObject? {

		let result: [String: Any] = [

			Constants.Key.TxnID: transactionID,
			Constants.Key.Medium: medium.stringRepresentation,
			Constants.Key.ShareAction: shareAction.rawValue
		]

		return result as AnyObject
	}

	//MARK: Methods

	/**
	 Initializes data model with transaction ID, medium and sharing action.

	 - parameter transactionID: Transaction ID.
	 - parameter medium:        Medium.
	 - parameter shareAction:   Sharing option.

	 - returns: TPAPIShareAppRequestModel
	 */
	internal init(transactionID: String, medium: SharingOption, shareAction: SharingStatus) {

		super.init()

		self.transactionID = transactionID
		self.medium = medium
		self.shareAction = shareAction
	}

	public required init() { super.init() }
}
