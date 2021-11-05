//
//  RegistrationComplaintRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for register compliant request.
internal class RegistrationComplaintRequestModel: goTapAPI.RequestModel {

	//MARK: - Public -
	//MARK: Properties

	/// Reference value.
	private(set) var referenceValue: String = String.tap_empty

	override var serializedModel: AnyObject? {

		guard var result = super.serializedModel as? [String: Any] else { return nil }

		result[goTapAPI.Constants.Key.AppData] = goTapAPI.ApplicationData.sharedInstance.serializedModel!
		result[goTapAPI.Constants.Key.RefValue] = goTapAPI.ApplicationData.sharedInstance.phoneNumber ?? String.tap_empty
		result[goTapAPI.Constants.Key.RefNmbr] = referenceValue

		return result as AnyObject
	}

	//MARK: Methods

	/**
	 Initializes data model with reference value.

	 - parameter referenceValue: Reference value.

	 - returns: TPAPIRegisterCompliantRequestModel
	 */
	init(referenceValue: String) {

		super.init()

		self.referenceValue = referenceValue
	}

	public required init() { super.init() }
}
