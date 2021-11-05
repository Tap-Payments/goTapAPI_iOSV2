//
//  PhoneVerificationResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/27/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Response model to verify phone.
public class PhoneVerificationResponseModel: goTapAPI.ResponseModel {

	//MARK: - Public -
	//MARK: Properties

	/// Application license code.
	internal private(set) var appLicenseCode: String? {

		didSet {

			if Client.sharedInstance.canStoreSessionIDAndAppLicenseCode == false && self.appLicenseCode != nil {

				self.appLicenseCode = nil
				return
			}

			goTapAPI.Client.sharedInstance.dataSource!.saveToUserSettings(self.appLicenseCode, forKey: goTapAPI.Constants.Key.UserSettings.AppLicenseCode)
		}
	}

	/// Active sectors.
	public private(set) var activeSectors: [goTapAPI.DetailedSector] = []

	/// Future sectors.
	public private(set) var futureSectors: [goTapAPI.DetailedSector] = []

	/// Primary number List ID.
	public private(set) var primaryNumber: goTapAPI.ListID?

	/// Minimal schedule amount.
	public private(set) var minimalAmount: Foundation.Decimal = Foundation.Decimal.zero

	/// Maximal schedule amount.
	public private(set) var maximalAmount: Foundation.Decimal = Foundation.Decimal.zero

	/// Default schedule day.
	public private(set) var scheduleDay: Int64 = 1

	internal override var serializedModel: AnyObject? {

		let emptyArray: [AnyObject] = []

		var result: [String: Any] = [:]
		result[goTapAPI.Constants.Key.ActiveSectors] = goTapAPI.ParseHelper.serialize(array: activeSectors) ?? emptyArray
		result[goTapAPI.Constants.Key.NewSectors] = goTapAPI.ParseHelper.serialize(array: futureSectors) ?? emptyArray

		return result as AnyObject
	}

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.PhoneVerificationResponseModel else { return nil }

		let closure: (AnyObject) -> goTapAPI.DetailedSector? = { object in

			return goTapAPI.DetailedSector().dataModelWith(serializedObject: object)
		}

		let emptyArray: [goTapAPI.DetailedSector] = []
		let serializedActiveSectors = dictionary.parseArray(forKey: goTapAPI.Constants.Key.ActiveSectors) ?? emptyArray
		let serializedFutureSectors = dictionary.parseArray(forKey: goTapAPI.Constants.Key.NewSectors) ?? emptyArray

		let parsedActiveSectors: [goTapAPI.DetailedSector]? = goTapAPI.ParseHelper.parse(array: serializedActiveSectors, usingClosure: closure)
		let parsedFutureSectors: [goTapAPI.DetailedSector]? = goTapAPI.ParseHelper.parse(array: serializedFutureSectors, usingClosure: closure)

		model.activeSectors = parsedActiveSectors == nil ? emptyArray : parsedActiveSectors!
		model.futureSectors = parsedFutureSectors == nil ? emptyArray : parsedFutureSectors!

		model.appLicenseCode = dictionary.parseString(forKey: goTapAPI.Constants.Key.APPLicenseCD)
		model.primaryNumber = goTapAPI.ListID().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: goTapAPI.Constants.Key.LstID) as AnyObject)

		model.minimalAmount = dictionary.parseAmount(forKey: goTapAPI.Constants.Key.MinAmount) ?? Foundation.Decimal.zero
		model.maximalAmount = dictionary.parseAmount(forKey: goTapAPI.Constants.Key.MaxAmount) ?? Foundation.Decimal.zero
		model.scheduleDay = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.schedule_day) ?? 1

		return model.tap_asSelf()
	}
}
