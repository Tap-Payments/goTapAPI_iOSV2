//
//  LinkEmailRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for link email request.
internal class LinkEmailRequestModel: goTapAPI.RequestModel {

	//MARK: - Public -
	//MARK: Properties

	/// Identifier.
	internal private(set) var identifier: String = String.tap_empty

	/// Transaction ID.
	internal private(set) var transactionID: String?

	/// Requirement.
	internal private(set) var requirement: goTapAPI.LinkEmailRequirement = goTapAPI.LinkEmailRequirement.SendReceiptAndLinkEmail

	internal override var serializedModel: AnyObject? {

		let emptyDict: [String: AnyObject] = [:]
		var result: [String: Any] = super.serializedModel as? [String: AnyObject] ?? emptyDict

		result[goTapAPI.Constants.Key.ID] = identifier
		result[goTapAPI.Constants.Key.TxnID] = transactionID ?? String.tap_empty
		result[goTapAPI.Constants.Key.ReqType] = requirement.stringRepresentation

		return result as AnyObject
	}

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.LinkEmailRequestModel else { return nil }

		guard let parsedIdentifier = dictionary.parseString(forKey: goTapAPI.Constants.Key.ID) else { return nil }
		guard let parsedTransactionID = dictionary.parseString(forKey: goTapAPI.Constants.Key.TxnID) else { return nil }

		model.identifier = parsedIdentifier
		model.transactionID = parsedTransactionID
		model.requirement = goTapAPI.LinkEmailRequirement.with(stringValue: dictionary.parseString(forKey: goTapAPI.Constants.Key.ReqType))

		return model.tap_asSelf()
	}

	/**
	 Initializes data model with identifier, transactionID and requirement.

	 - parameter identifier:    Identifier.
	 - parameter transactionID: Transaction ID.
	 - parameter requirement:   Requirement.

	 - returns: TPAPILinkEmailRequestModel.
	 */
	internal init(identifier: String, transactionID: String?, requirement: goTapAPI.LinkEmailRequirement) {

		super.init()

		self.identifier = identifier
		self.transactionID = transactionID
		self.requirement = requirement
	}

	public required init() { super.init() }
}
