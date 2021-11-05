//
//  RequestApplicationResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/21/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Response model for application request application.
public class RequestApplicationResponseModel: goTapAPI.ResponseModel {

	//MARK: - Public -
	//MARK: Properties

	/// Country name.
	public private(set) var countryName: String = String.tap_empty

	/// Country code.
	public private(set) var countryCode: String = String.tap_empty

	/// Country image URL.
	public private(set) var countryImageURL: URL?

	/// Phone number.
	public private(set) var phoneNumber: String = String.tap_empty

	/// Description.
	public private(set) var descriptionString: String = String.tap_empty

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.RequestApplicationResponseModel else { return nil }

		guard let parsedCountryName = dictionary.parseString(forKey: goTapAPI.Constants.Key.CountryName) else { return nil }
		guard let parsedCountryCode = dictionary.parseString(forKey: goTapAPI.Constants.Key.CountryCode) else { return nil }
		guard let parsedCountryImageURL = dictionary.parseURL(forKey: goTapAPI.Constants.Key.CountryImgUrl) else { return nil }
		guard let parsedPhoneNumber = dictionary.parseString(forKey: goTapAPI.Constants.Key.PhoneNumber) else { return nil }
		guard let parsedDescriptionString = dictionary.parseString(forKey: goTapAPI.Constants.Key.Description) else { return nil }

		model.countryName = parsedCountryName
		model.countryCode = parsedCountryCode
		model.countryImageURL = parsedCountryImageURL
		model.phoneNumber = parsedPhoneNumber
		model.descriptionString = parsedDescriptionString

		return model.tap_asSelf()
	}
}
