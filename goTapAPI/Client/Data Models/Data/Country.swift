//
//  Country.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/5/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Country data model.
public class Country: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Available add to list screens.
	public private(set) var availableAddToListScreens: AddToListScreen = AddToListScreen.None

	/// Flag URL
	public var flagURL: URL? {

		return UrlExtension.with(string: flagURLString)
	}

	/// Flag local image name. If nil, use flagURL to load the image.
	public private(set) var flagImageName: String?

	/// ID number validation pattern.
	public private(set) var idPattern: String?

	/// ISD Number.
	public private(set) var isdNumber: String?

	/// ISO code.
	public private(set) var isoCode: ISOCode?

	/// Language code.
	public private(set) var languageCode: String?

	/// Number pattern.
	public private(set) var numberPattern: String?

	/// Country name.
	public var name: String? {

		if let twoLetteredISOCode = isoCode?.twoLetters {

			return Client.sharedInstance.dataSource!.countryNameFor(twoLetteredISOCode)
		}

		return String.tap_empty
	}

	/// Displayed ISD number.
	public var displayedISDNumber: String {

		let isdNumberLength = isdNumber?.Length ?? 0
		if isdNumberLength == 0 {

			return String.tap_empty
		}

		return "+\(isdNumber!)"
	}

	/// Defines if country is supported for registration.
	public private(set) var supportedForRegistration = false

	/// Serialized model for ApplicationData inner country model.
	internal var applicationDataSerializedModel: AnyObject {

		var result: [String: Any] = [:]

		result.setNullable(value: self.isoCode?.twoLetters, forKey: Constants.Key.Code)
		result.setNullable(value: self.isdNumber, forKey: Constants.Key.ISDNMbr)
		result.setNullable(value: self.name, forKey: Constants.Key.Name)

		return result as AnyObject
	}

	internal override var serializedModel: AnyObject? {

		var result: [String: Any] = [:]

		result[Constants.Key.AddListScreenID] = availableAddToListScreens.rawValue

		result.setNullable(value: flagURLString, forKey: Constants.Key.FlagURL)
		result.setNullable(value: idPattern, forKey: Constants.Key.IDPattern)
		result.setNullable(value: isdNumber, forKey: Constants.Key.ISDNMbr)
		result.setNullable(value: isoCode?.serializedModel, forKey: Constants.Key.ISOCode)
		result.setNullable(value: languageCode, forKey: Constants.Key.LangCode)
		result.setNullable(value: name, forKey: Constants.Key.Name)
		result.setNullable(value: numberPattern, forKey: Constants.Key.NumberPattern)

		return result as AnyObject
	}

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? Country else { return nil }

		model.availableAddToListScreens = AddToListScreen(rawValue: dictionary.parseInteger(forKey: Constants.Key.AddListScreenID) ?? AddToListScreen.None.rawValue)
		model.flagURLString = dictionary.parseString(forKey: Constants.Key.FlagURL)
		model.idPattern = dictionary.parseString(forKey: Constants.Key.IDPattern)
		model.isdNumber = dictionary.parseString(forKey: Constants.Key.ISDNMbr)
		model.isoCode = ISOCode().dataModelWith(serializedObject: dictionary.parseDictionary(forKey: Constants.Key.ISOCode) as AnyObject)
		model.languageCode = dictionary.parseString(forKey: Constants.Key.LangCode)
		model.numberPattern = dictionary.parseString(forKey: Constants.Key.NumberPattern)

		return model.tap_asSelf()
	}

	public required init() { super.init() }

	/**
	 Initializes data model with the given fields.

	 - parameter isdNumber:     ISD number.
	 - parameter isoCode:       ISO code.
	 - parameter numberPattern: Number pattern.
	 - parameter languageCode:  Language code.
	 - parameter flagImageName: Flag image name.

	 - returns: New instance of TPAPICountry.
	 */
	public init(isdNumber: String?, isoCode: ISOCode?, numberPattern: String?, idPattern: String?, availableAddToListScreens: AddToListScreen, languageCode: String?, flagImageName: String?, supportedForRegistration: Bool) {

		super.init()

		self.isdNumber = DoubleExtension.convert(doubleToString: ((isdNumber ?? "0") as NSString).doubleValue, withNumberOfDigitsAfterComma: 0)
		self.isoCode = isoCode
		self.numberPattern = numberPattern
		self.idPattern = idPattern
		self.languageCode = languageCode
		self.flagImageName = flagImageName
		self.availableAddToListScreens = availableAddToListScreens
		self.supportedForRegistration = supportedForRegistration
	}

	public static func withJsonString(jsonString: String?) -> Country? {

		guard let dictionary = Swift.Dictionary<String, AnyObject>.from(jsonString) else { return nil }

		return self.withDictionary(dictionary)
	}

	public static func withDictionary(_ dictionary: Swift.Dictionary<String, AnyObject>) -> Country? {

		var availableAddToListScreens: AddToListScreen = AddToListScreen.None

		if let availableAddToListScreenID = dictionary.parseInteger(forKey: Constants.Key.AddListScreenID) {

			availableAddToListScreens = AddToListScreen(rawValue: availableAddToListScreenID)
		}
		else {

			if let canAddMobile = dictionary.parseBoolean(forKey: Constants.Key.CountriesJSON.Can_Add_Mobile), canAddMobile == true {

				availableAddToListScreens = AddToListScreen(rawValue: availableAddToListScreens.rawValue + AddToListScreen.Mobile.rawValue)
			}

			if let canAddID = dictionary.parseBoolean(forKey: Constants.Key.CountriesJSON.Can_Add_Civil_Id), canAddID == true {

				availableAddToListScreens = AddToListScreen(rawValue: availableAddToListScreens.rawValue + AddToListScreen.ID.rawValue)
			}
		}

		var isdNumber: String? = nil
		if let parsedISDNumber = dictionary.parseString(forKey: Constants.Key.CountriesPlist.ISDNumber) {

			isdNumber = parsedISDNumber
		}
		else if let parsedISD_Number = dictionary.parseString(forKey: Constants.Key.CountriesJSON.ISD_Number) {

			isdNumber = parsedISD_Number
		}
		else if let parsedISDNMbr = dictionary.parseString(forKey: Constants.Key.ISDNMbr) {

			isdNumber = parsedISDNMbr
		}

		var numberPattern: String? = nil
		if let parsedPhoneNumberPattern = dictionary.parseString(forKey: Constants.Key.CountriesPlist.PhoneNumberPattern) {

			numberPattern = parsedPhoneNumberPattern
		}
		else if let parsedPhone_Number_Validation = dictionary.parseString(forKey: Constants.Key.CountriesJSON.Phone_Number_Validation) {

			numberPattern = parsedPhone_Number_Validation
		}
		else if let parsedNumberPattern = dictionary.parseString(forKey: Constants.Key.NumberPattern) {

			numberPattern = parsedNumberPattern
		}

		var isoCode: ISOCode? = nil
		if let dictionary = dictionary.parseDictionary(forKey: Constants.Key.ISOCode) {

			isoCode = ISOCode().dataModelWith(serializedObject: dictionary)
		}
		else {

			isoCode = ISOCode.dataModelWith(plist: dictionary)
		}

		return Country(isdNumber: isdNumber,
								isoCode: isoCode,
								numberPattern: numberPattern,
								idPattern: dictionary.parseString(forKey: Constants.Key.IDPattern) ?? dictionary.parseString(forKey: Constants.Key.CountriesJSON.Civil_Id_Validation),
								availableAddToListScreens: availableAddToListScreens,
								languageCode: dictionary.parseString(forKey: Constants.Key.CountriesPlist.LanguageCode),
								flagImageName: dictionary.parseString(forKey: Constants.Key.CountriesPlist.FlagImageName),
								supportedForRegistration: dictionary.parseBoolean(forKey: Constants.Key.CountriesJSON.Can_Register) ?? false)
	}

	//MARK: - Private -
	//MARK: Properties

	private var flagURLString: String?
}
