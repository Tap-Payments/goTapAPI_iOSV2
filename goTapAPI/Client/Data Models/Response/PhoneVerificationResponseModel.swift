//
//  PhoneVerificationResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/27/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Response model to verify phone.
public class PhoneVerificationResponseModel: ResponseModel {

	//MARK: - Public -
	//MARK: Properties

	/// Application license code.
	internal private(set) var appLicenseCode: String? {

		didSet {

			if Client.sharedInstance.canStoreSessionIDAndAppLicenseCode == false && self.appLicenseCode != nil {

				self.appLicenseCode = nil
				return
			}

			Client.sharedInstance.dataSource!.saveToUserSettings(self.appLicenseCode, forKey: Constants.Key.UserSettings.AppLicenseCode)
		}
	}

	/// Active sectors.
	public private(set) var activeSectors: [DetailedSector] = []

	/// Future sectors.
	public private(set) var futureSectors: [DetailedSector] = []

	/// Primary number List ID.
	public private(set) var primaryNumber: ListID?

	/// Minimal schedule amount.
	public private(set) var minimalAmount: Foundation.Decimal = Foundation.Decimal.zero

	/// Maximal schedule amount.
	public private(set) var maximalAmount: Foundation.Decimal = Foundation.Decimal.zero

	/// Default schedule day.
	public private(set) var scheduleDay: Int64 = 1

	internal override var serializedModel: AnyObject? {

		let emptyArray: [AnyObject] = []

		var result: [String: Any] = [:]
		result[Constants.Key.ActiveSectors] = ParseHelper.serialize(array: activeSectors) ?? emptyArray
		result[Constants.Key.NewSectors] = ParseHelper.serialize(array: futureSectors) ?? emptyArray

		return result as AnyObject
	}

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? PhoneVerificationResponseModel else { return nil }

		let closure: (AnyObject) -> DetailedSector? = { object in

			return DetailedSector().dataModelWith(serializedObject: object)
		}

		let emptyArray: [DetailedSector] = []
		let serializedActiveSectors = dictionary.parseArray(forKey: Constants.Key.ActiveSectors) ?? emptyArray
		let serializedFutureSectors = dictionary.parseArray(forKey: Constants.Key.NewSectors) ?? emptyArray

		let parsedActiveSectors: [DetailedSector]? = ParseHelper.parse(array: serializedActiveSectors, usingClosure: closure)
		let parsedFutureSectors: [DetailedSector]? = ParseHelper.parse(array: serializedFutureSectors, usingClosure: closure)

		model.activeSectors = parsedActiveSectors == nil ? emptyArray : parsedActiveSectors!
		model.futureSectors = parsedFutureSectors == nil ? emptyArray : parsedFutureSectors!

		model.appLicenseCode = dictionary.parseString(forKey: Constants.Key.APPLicenseCD)
		model.primaryNumber = ListID().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: Constants.Key.LstID) as AnyObject)

		model.minimalAmount = dictionary.parseAmount(forKey: Constants.Key.MinAmount) ?? Foundation.Decimal.zero
		model.maximalAmount = dictionary.parseAmount(forKey: Constants.Key.MaxAmount) ?? Foundation.Decimal.zero
		model.scheduleDay = dictionary.parseInteger(forKey: Constants.Key.schedule_day) ?? 1

		return model.tap_asSelf()
	}
}
