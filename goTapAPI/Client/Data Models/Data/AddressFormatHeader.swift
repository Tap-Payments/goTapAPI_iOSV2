//
//  AddressFormatHeader.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/24/17.
//  Copyright © 2017 Tap Payments. All rights reserved.
//

/// Address format details model.
public class AddressFormatHeader: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Country ID.
	public private(set) var countryID: Int64 = 0

	/// Field ID.
	public private(set) var fieldID: Int64 = 0

	/// Field name.
	public private(set) var fieldName: String = String.tap_empty

	/// Field data type.
	public private(set) var fieldDataType: String = String.tap_empty

	/// Maximal field length.
	public private(set) var maximalLength: Int64 = 0

	/// Display order.
	public private(set) var displayOrder: Int64 = 0

	//MARK: - Internal -
	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? AddressFormatHeader else { return nil }

		model.countryID = dictionary.parseInteger(forKey: Constants.Key.CntryID) ?? 0
		model.fieldID = dictionary.parseInteger(forKey: Constants.Key.FldID) ?? 0
		model.fieldName = dictionary.parseString(forKey: Constants.Key.FldName) ?? String.tap_empty
		model.fieldDataType = dictionary.parseString(forKey: Constants.Key.FldDataTyp) ?? String.tap_empty
		model.maximalLength = dictionary.parseInteger(forKey: Constants.Key.MaxLngth) ?? 0
		model.displayOrder = dictionary.parseInteger(forKey: Constants.Key.DispOrder) ?? 0

		return model.tap_asSelf()
	}
}
