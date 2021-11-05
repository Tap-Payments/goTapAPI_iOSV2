//
//  ApplicationData.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/4/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Application data to register app.
public class ApplicationData: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Shared application data.
	public static let sharedInstance: goTapAPI.ApplicationData = goTapAPI.ApplicationData()

	/// Language code.
	internal private(set) var languageCode: String = String.tap_empty

	/// Phone number.
	public private(set) var phoneNumber: String?

	/// SIM card code.
	internal private(set) var simCardCode: String?

	/// Application installs counter.
	internal private(set) var appInstallsCounter: Int64 = 1

	/// Application ID.
	internal private(set) var applicationID: String?

	/// Device ID.
	internal private(set) var deviceID: String?

	/// Device name.
	internal private(set) var deviceName: String = String.tap_empty

	/// Device model.
	internal private(set) var deviceModel: String = String.tap_empty

	/// Localized device model.
	internal private(set) var localizedDeviceModel: String = String.tap_empty

	/// Operating system.
	internal private(set) var systemName: String = String.tap_empty

	/// OS version.
	internal private(set) var systemVersion: String = String.tap_empty

	/// User interface idiom.
	internal private(set) var userInterfaceIdiom: String = String.tap_empty

	/// Country.
	public private(set) var country: goTapAPI.Country?

	/// ISD number.
	internal private(set) var isdNumber: String = String.tap_empty

	/// Location.
	internal private(set) var location: goTapAPI.LocationData?

	internal override var serializedModel: AnyObject? {

		//FIXME: Fix this insanity.

		let simLength = simCardCode?.Length ?? 0
		if simLength == 0 {

			self.simCardCode = "123"
		}

		self.languageCode = goTapAPI.Client.sharedInstance.dataSource!.languageCode().uppercased()

		var result: [String: Any] = [:]

		result[goTapAPI.Constants.Key.LangCode] = self.languageCode
		result[goTapAPI.Constants.Key.PhoneNmbr] = self.phoneNumber ?? NSNull()
		result[goTapAPI.Constants.Key.SIMCardCode] = self.simCardCode ?? NSNull()
		result[goTapAPI.Constants.Key.AppInsCount] = self.appInstallsCounter
		result[goTapAPI.Constants.Key.APPID] = self.applicationID ?? NSNull()
		result[goTapAPI.Constants.Key.DeviceID] = self.deviceID ?? String.tap_empty
		result[goTapAPI.Constants.Key.DeviceName] = self.deviceName
		result[goTapAPI.Constants.Key.DeviceModel] = self.deviceModel
		result[goTapAPI.Constants.Key.LocalizedModel] = self.localizedDeviceModel
		result[goTapAPI.Constants.Key.SystemName] = self.systemName
		result[goTapAPI.Constants.Key.SystemVersion] = self.systemVersion
		result[goTapAPI.Constants.Key.UserInterfaceIdiom] = self.userInterfaceIdiom
		result[goTapAPI.Constants.Key.Cntry] = self.country?.applicationDataSerializedModel ?? NSNull()
		result[goTapAPI.Constants.Key.ISDNmbr] = self.isdNumber
		result[goTapAPI.Constants.Key.Location] = self.location?.serializedModel ?? NSNull()

		return result as AnyObject
	}

	//MARK: Methods

	/**
	 Updates data model with serialized model.

	 - parameter model: Serialized model.
	 */
	internal func updateWithSerializedModel(model: AnyObject?) {

		guard let dictionary = model as? [String: AnyObject] else { return }

		if let updatedLanguageCode = dictionary.parseString(forKey: goTapAPI.Constants.Key.LangCode) {

			self.languageCode = updatedLanguageCode
		}

		if let updatedPhoneNumber = dictionary.parseString(forKey: goTapAPI.Constants.Key.PhoneNmbr) {

			self.phoneNumber = updatedPhoneNumber
		}

		if let updatedSIMCardCode = dictionary.parseString(forKey: goTapAPI.Constants.Key.SIMCardCode) {

			self.simCardCode = updatedSIMCardCode
		}

		if let updatedDeviceID = dictionary.parseString(forKey: goTapAPI.Constants.Key.DeviceID) {

			self.deviceID = updatedDeviceID
		}

		if let updatedDeviceName = dictionary.parseString(forKey: goTapAPI.Constants.Key.DeviceName) {

			self.deviceName = updatedDeviceName
		}

		if let updatedDeviceModel = dictionary.parseString(forKey: goTapAPI.Constants.Key.DeviceModel) {

			self.deviceModel = updatedDeviceModel
		}

		if let updatedLocalizedDeviceModel = dictionary.parseString(forKey: goTapAPI.Constants.Key.LocalizedModel) {

			self.localizedDeviceModel = updatedLocalizedDeviceModel
		}

		if let updatedSystemName = dictionary.parseString(forKey: goTapAPI.Constants.Key.SystemName) {

			self.systemName = updatedSystemName
		}

		if let updatedSystemVersion = dictionary.parseString(forKey: goTapAPI.Constants.Key.SystemVersion) {

			self.systemVersion = updatedSystemVersion
		}

		if let updatedUserInterfaceIdiom = dictionary.parseString(forKey: goTapAPI.Constants.Key.UserInterfaceIdiom) {

			self.userInterfaceIdiom = updatedUserInterfaceIdiom
		}

		if let updatedISDNumber = dictionary.parseString(forKey: goTapAPI.Constants.Key.ISDNmbr) {

			self.isdNumber = updatedISDNumber
		}

		if let updatedCountryDictionary = dictionary.parseDictionary(forKey: goTapAPI.Constants.Key.Cntry) {

			self.country = goTapAPI.Country().dataModelWith(serializedObject: updatedCountryDictionary as AnyObject)
		}

		if let updatedLocationDictionary = dictionary.parseDictionary(forKey: goTapAPI.Constants.Key.Location) {

			self.location = goTapAPI.LocationData().dataModelWith(serializedObject: updatedLocationDictionary)
		}
	}

	internal func storeApplicationID(_ appID: String?) {

		self.applicationID = appID
		goTapAPI.Client.sharedInstance.dataSource!.saveToUserSettings(appID, forKey: goTapAPI.Constants.Key.UserSettings.AppID)
	}

	internal func storeDeviceID(_ devID: String?) {

		self.deviceID = devID
		goTapAPI.Client.sharedInstance.dataSource!.saveToKeychain(devID, forKey: goTapAPI.Constants.Key.UserSettings.DeviceID)
	}

	internal func storeCountry(_ userCountry: goTapAPI.Country?) {

		self.country = userCountry
		self.isdNumber = userCountry?.isdNumber ?? String.tap_empty
		goTapAPI.Client.sharedInstance.dataSource!.saveToUserSettings(userCountry?.isoCode?.twoLetters, forKey: goTapAPI.Constants.Key.UserSettings.PhoneNumberCountryCode)
	}

	internal func storePhoneNumber(_ userPhoneNumber: String?) {

		self.phoneNumber = userPhoneNumber
		goTapAPI.Client.sharedInstance.dataSource?.saveToUserSettings(userPhoneNumber, forKey: goTapAPI.Constants.Key.UserSettings.PhoneNumber)
	}

	internal func storeLocation(_ userLocation: goTapAPI.LocationData?) {

		self.location = userLocation
	}

	//MARK: - Private -
	//MARK: Methods

	public required init() {

		super.init()
		self.loadDeviceAndUserInformation()
	}

	private func loadDeviceAndUserInformation() {

		let clientDataSource = goTapAPI.Client.sharedInstance.dataSource!

		self.languageCode = clientDataSource.preferredSystemLanguageCode().Substring(loc: 0, len: 1).uppercased()
		self.simCardCode = clientDataSource.mobileCountryCode()
		self.deviceID = clientDataSource.stringFromKeychain(forKey: goTapAPI.Constants.Key.UserSettings.DeviceID)
		self.deviceName = clientDataSource.deviceName()
		self.deviceModel = clientDataSource.deviceModel()
		self.localizedDeviceModel = clientDataSource.localizedDeviceModel()
		self.systemName = clientDataSource.operatingSystemName()
		self.systemVersion = clientDataSource.operatingSystemVersion()
		self.appInstallsCounter = clientDataSource.numberOfApplicationInstallations()
		self.applicationID = clientDataSource.stringFromUserSettings(forKey: goTapAPI.Constants.Key.UserSettings.AppID)
		self.userInterfaceIdiom = clientDataSource.userInterfaceIdiom().stringRepresentation
		self.phoneNumber = clientDataSource.stringFromUserSettings(forKey: goTapAPI.Constants.Key.UserSettings.PhoneNumber)

		if let isdNumber = clientDataSource.stringFromUserSettings(forKey: goTapAPI.Constants.Key.UserSettings.PhoneNumberCountryCode) {

			self.country = clientDataSource.countryWith(isdNumber)
			self.isdNumber = self.country?.isdNumber ?? String.tap_empty
		}
	}
}
