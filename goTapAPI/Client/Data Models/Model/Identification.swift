//
//  Identification.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Helpful additions to ALIdentification.
public class Identification {

	//MARK: - Public -
	//MARK: Properties

	/// Document number.
	public private(set) var documentType: String

	/// Document number.
	public private(set) var documentNumber: String

	/// Surnames
	public private(set) var surnames: String

	/// Given names.
	public private(set) var givenNames: String

	/// Issuing country code.
	public private(set) var issuingCountryCode: String

	/// Nationality country code.
	public private(set) var nationalityCountryCode: String

	/// Day of birth.
	public private(set) var dayOfBirth: String

	/// Expiration date.
	public private(set) var expirationDate: String

	/// Sex.
	public private(set) var sex: String

	/// Personal number.
	public private(set) var personalNumber: String

	/// Returns business fields for API.
	internal var businessFields: [BusinessField] {

		var bFields: [BusinessField] = []

		if documentType.Length > 0 {

			bFields.append(BusinessField(name: Constants.Value.DOC_TYPE, value: documentType))
		}

		if documentNumber.Length > 0 {

			bFields.append(BusinessField(name: Constants.Value.DOC_NO, value: documentNumber))
		}

		if surnames.Length > 0 {

			bFields.append(BusinessField(name: Constants.Value.SURNAME, value: surnames))
		}

		if givenNames.Length > 0 {

			bFields.append(BusinessField(name: Constants.Value.GIVEN_NAMES, value: givenNames))
		}

		if issuingCountryCode.Length > 0 {

			bFields.append(BusinessField(name: Constants.Value.ISSUE_CNTRY_CD, value: issuingCountryCode))
		}

		if nationalityCountryCode.Length > 0 {

			bFields.append(BusinessField(name: Constants.Value.NATIONAL_CNTRY_CD, value: nationalityCountryCode))
		}

		if dayOfBirth.Length > 0 {

			bFields.append(BusinessField(name: Constants.Value.DOB, value: dayOfBirth))
		}

		if expirationDate.Length > 0 {

			bFields.append(BusinessField(name: Constants.Value.EXP_DT, value: expirationDate))
		}

		if sex.Length > 0 {

			bFields.append(BusinessField(name: Constants.Value.SEX, value: sex))
		}

		if personalNumber.Length > 0 {

			bFields.append(BusinessField(name: Constants.Value.ID_NO, value: personalNumber))
		}

		return bFields
	}

	//MARK: - Methods -

	public init(documentType: String = String.tap_empty,
				documentNumber: String = String.tap_empty,
				surnames: String = String.tap_empty,
				givenNames: String = String.tap_empty,
				issuingCountryCode: String = String.tap_empty,
				nationalityCountryCode: String = String.tap_empty,
				dayOfBirth: String = String.tap_empty,
				expirationDate: String = String.tap_empty,
				sex: String = String.tap_empty,
				personalNumber: String = String.tap_empty) {

		self.documentType = documentType
		self.documentNumber = documentNumber
		self.surnames = surnames
		self.givenNames = givenNames
		self.issuingCountryCode = issuingCountryCode
		self.nationalityCountryCode = nationalityCountryCode
		self.dayOfBirth = dayOfBirth
		self.expirationDate = expirationDate
		self.sex = sex
		self.personalNumber = personalNumber
	}

	public convenience init(issuingCountryCode issCountryCode: String, personalNumber pNumber: String) {

		self.init(documentType: String.tap_empty, documentNumber: String.tap_empty, surnames: String.tap_empty, givenNames: String.tap_empty, issuingCountryCode: issCountryCode, nationalityCountryCode: String.tap_empty, dayOfBirth: String.tap_empty, expirationDate: String.tap_empty, sex: String.tap_empty, personalNumber: pNumber)
	}
}
