//
//  MobileVerify.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Data model to verify phone.
internal class MobileVerify: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Phone number.
	private(set) var phoneNumber: String?

	/// Confirmation code.
	private(set) var confirmationCode: String?

	/// SIM card code.
	private(set) var simCardCode: String?

	/// Device ID.
	private(set) var deviceID: String?

	/// Country.
	private(set) var country: Country?

	internal override var serializedModel: AnyObject? {

		var result: [String: Any] = [:]

		result[Constants.Key.PhoneNmbr] = phoneNumber ?? NSNull()
		result[Constants.Key.CnfrmCode] = confirmationCode ?? NSNull()
		result[Constants.Key.SIMCardCode] = simCardCode ?? "123"
		result[Constants.Key.DeviceID] = deviceID ?? String.tap_empty
		result[Constants.Key.Cntry] = country?.applicationDataSerializedModel ?? NSNull()

		return result as AnyObject
	}

	//MARK: Methods

	public required init() { super.init() }

	/**
	 Initializes data model with all the information.

	 - parameter phoneNumber:      Phone number.
	 - parameter confirmationCode: Confirmation code.
	 - parameter simCardCode:      SIM card code.
	 - parameter deviceID:         Device ID.
	 - parameter country:          Country.

	 - returns: New instance of TPAPIMobileVerify.
	 */
	init(phoneNumber: String?, confirmationCode: String?, simCardCode: String?, deviceID: String?, country: Country?) {

		super.init()

		self.phoneNumber = phoneNumber
		self.confirmationCode = confirmationCode
		self.simCardCode = simCardCode
		self.deviceID = deviceID
		self.country = country
	}
}
