//
//  ISOCode.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/5/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// ISO code data model.
public class ISOCode: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Two letters ISO code.
	public private(set) var twoLetters: String = String.tap_empty

	/// Three letters ISO code.
	public private(set) var threeLetters: String = String.tap_empty

	internal override var serializedModel: AnyObject? {

		get {

			var result: [String: Any] = [:]

			result[Constants.Key.twoLetters] = twoLetters
			result[Constants.Key.threeLetters] = threeLetters

			return result as AnyObject
		}
	}

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? ISOCode else { return nil }

		guard let twoLettersCode = dictionary.parseString(forKey: Constants.Key.twoLetters) else { return nil }
		guard let threeLettersCode = dictionary.parseString(forKey: Constants.Key.threeLetters) else { return nil }

		model.twoLetters = twoLettersCode
		model.threeLetters = threeLettersCode

		return model.tap_asSelf()
	}

	internal static func dataModelWith(plist: [String: AnyObject]?) -> ISOCode? {

		guard let dictionary = plist else { return nil }

		guard let twoLettersCode = dictionary.parseString(forKey: Constants.Key.ISOCodePlist.TwoLetters) ?? dictionary.parseString(forKey: Constants.Key.CountriesJSON.Two_Letter_ISO_Code) else { return nil }
		guard let threeLettersCode = dictionary.parseString(forKey: Constants.Key.ISOCodePlist.ThreeLetters) ?? dictionary.parseString(forKey: Constants.Key.CountriesJSON.Three_Letter_ISO_Code) else { return nil }

		return ISOCode(twoLetters: twoLettersCode, threeLetters: threeLettersCode)
	}

	/**
	 Initializes model with two and three lettered codes.

	 - parameter twoLetters:   Two lettered code.
	 - parameter threeLetters: Three lettered code.

	 - returns: TPAPIISOCode model.
	 */
	internal init(twoLetters: String, threeLetters: String) {

		super.init()

		self.twoLetters = twoLetters
		self.threeLetters = threeLetters
	}

	public required init() { super.init() }
}
