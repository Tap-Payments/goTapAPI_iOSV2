//
//  ApplicationData.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/4/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Application data to register app.
public class ApplicationData: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Shared application data.
	public static let sharedInstance: ApplicationData = ApplicationData()

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
	public private(set) var country: Country?

	/// ISD number.
	internal private(set) var isdNumber: String = String.tap_empty

	/// Location.
	internal private(set) var location: LocationData?

	internal override var serializedModel: AnyObject? {

		//FIXME: Fix this insanity.

		let simLength = simCardCode?.Length ?? 0
		if simLength == 0 {

			self.simCardCode = "123"
		}

		self.languageCode = Client.sharedInstance.dataSource!.languageCode().uppercased()

		var result: [String: Any] = [:]

		result[Constants.Key.LangCode] = self.languageCode
		result[Constants.Key.PhoneNmbr] = self.phoneNumber ?? NSNull()
		result[Constants.Key.SIMCardCode] = self.simCardCode ?? NSNull()
		result[Constants.Key.AppInsCount] = self.appInstallsCounter
		result[Constants.Key.APPID] = self.applicationID ?? NSNull()
		result[Constants.Key.DeviceID] = self.deviceID ?? String.tap_empty
		result[Constants.Key.DeviceName] = self.deviceName
		result[Constants.Key.DeviceModel] = self.deviceModel
		result[Constants.Key.LocalizedModel] = self.localizedDeviceModel
		result[Constants.Key.SystemName] = self.systemName
		result[Constants.Key.SystemVersion] = self.systemVersion
		result[Constants.Key.UserInterfaceIdiom] = self.userInterfaceIdiom
		result[Constants.Key.Cntry] = self.country?.applicationDataSerializedModel ?? NSNull()
		result[Constants.Key.ISDNmbr] = self.isdNumber
		result[Constants.Key.Location] = self.location?.serializedModel ?? NSNull()

		return result as AnyObject
	}

	//MARK: Methods

	/**
	 Updates data model with serialized model.

	 - parameter model: Serialized model.
	 */
	internal func updateWithSerializedModel(model: AnyObject?) {

		guard let dictionary = model as? [String: AnyObject] else { return }

		if let updatedLanguageCode = dictionary.parseString(forKey: Constants.Key.LangCode) {

			self.languageCode = updatedLanguageCode
		}

		if let updatedPhoneNumber = dictionary.parseString(forKey: Constants.Key.PhoneNmbr) {

			self.phoneNumber = updatedPhoneNumber
		}

		if let updatedSIMCardCode = dictionary.parseString(forKey: Constants.Key.SIMCardCode) {

			self.simCardCode = updatedSIMCardCode
		}

		if let updatedDeviceID = dictionary.parseString(forKey: Constants.Key.DeviceID) {

			self.deviceID = updatedDeviceID
		}

		if let updatedDeviceName = dictionary.parseString(forKey: Constants.Key.DeviceName) {

			self.deviceName = updatedDeviceName
		}

		if let updatedDeviceModel = dictionary.parseString(forKey: Constants.Key.DeviceModel) {

			self.deviceModel = updatedDeviceModel
		}

		if let updatedLocalizedDeviceModel = dictionary.parseString(forKey: Constants.Key.LocalizedModel) {

			self.localizedDeviceModel = updatedLocalizedDeviceModel
		}

		if let updatedSystemName = dictionary.parseString(forKey: Constants.Key.SystemName) {

			self.systemName = updatedSystemName
		}

		if let updatedSystemVersion = dictionary.parseString(forKey: Constants.Key.SystemVersion) {

			self.systemVersion = updatedSystemVersion
		}

		if let updatedUserInterfaceIdiom = dictionary.parseString(forKey: Constants.Key.UserInterfaceIdiom) {

			self.userInterfaceIdiom = updatedUserInterfaceIdiom
		}

		if let updatedISDNumber = dictionary.parseString(forKey: Constants.Key.ISDNmbr) {

			self.isdNumber = updatedISDNumber
		}

		if let updatedCountryDictionary = dictionary.parseDictionary(forKey: Constants.Key.Cntry) {

			self.country = Country().dataModelWith(serializedObject: updatedCountryDictionary as AnyObject)
		}

		if let updatedLocationDictionary = dictionary.parseDictionary(forKey: Constants.Key.Location) {

			self.location = LocationData().dataModelWith(serializedObject: updatedLocationDictionary)
		}
	}

	internal func storeApplicationID(_ appID: String?) {

		self.applicationID = appID
		Client.sharedInstance.dataSource!.saveToUserSettings(appID, forKey: Constants.Key.UserSettings.AppID)
	}

	internal func storeDeviceID(_ devID: String?) {

		self.deviceID = devID
		Client.sharedInstance.dataSource!.saveToKeychain(devID, forKey: Constants.Key.UserSettings.DeviceID)
	}

	internal func storeCountry(_ userCountry: Country?) {

		self.country = userCountry
		self.isdNumber = userCountry?.isdNumber ?? String.tap_empty
		Client.sharedInstance.dataSource!.saveToUserSettings(userCountry?.isoCode?.twoLetters, forKey: Constants.Key.UserSettings.PhoneNumberCountryCode)
	}

	internal func storePhoneNumber(_ userPhoneNumber: String?) {

		self.phoneNumber = userPhoneNumber
		Client.sharedInstance.dataSource?.saveToUserSettings(userPhoneNumber, forKey: Constants.Key.UserSettings.PhoneNumber)
	}

	internal func storeLocation(_ userLocation: LocationData?) {

		self.location = userLocation
	}

	//MARK: - Private -
	//MARK: Methods

	public required init() {

		super.init()
		self.loadDeviceAndUserInformation()
	}

	private func loadDeviceAndUserInformation() {

		let clientDataSource = Client.sharedInstance.dataSource!

		self.languageCode = clientDataSource.preferredSystemLanguageCode().Substring(loc: 0, len: 1).uppercased()
		self.simCardCode = clientDataSource.mobileCountryCode()
		self.deviceID = clientDataSource.stringFromKeychain(forKey: Constants.Key.UserSettings.DeviceID)
		self.deviceName = clientDataSource.deviceName()
		self.deviceModel = clientDataSource.deviceModel()
		self.localizedDeviceModel = clientDataSource.localizedDeviceModel()
		self.systemName = clientDataSource.operatingSystemName()
		self.systemVersion = clientDataSource.operatingSystemVersion()
		self.appInstallsCounter = clientDataSource.numberOfApplicationInstallations()
		self.applicationID = clientDataSource.stringFromUserSettings(forKey: Constants.Key.UserSettings.AppID)
		self.userInterfaceIdiom = clientDataSource.userInterfaceIdiom().stringRepresentation
		self.phoneNumber = clientDataSource.stringFromUserSettings(forKey: Constants.Key.UserSettings.PhoneNumber)

		if let isdNumber = clientDataSource.stringFromUserSettings(forKey: Constants.Key.UserSettings.PhoneNumberCountryCode) {

			self.country = clientDataSource.countryWith(isdNumber)
			self.isdNumber = self.country?.isdNumber ?? String.tap_empty
		}
	}
}
