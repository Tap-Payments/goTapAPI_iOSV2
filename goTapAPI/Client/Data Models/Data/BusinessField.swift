//
//  BusinessField.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Business field data model.
internal class BusinessField: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Field name.
	internal private(set) var fieldName: String = String.tap_empty

	/// Field value.
	internal private(set) var fieldValue: String = String.tap_empty

	internal override var serializedModel: AnyObject? {

		let result: [String: Any] = [

			Constants.Key.FieldName: fieldName,
			Constants.Key.FieldVal: fieldValue
		]

		return result as AnyObject
	}

	//MARK: Methods

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? BusinessField else { return nil }

		guard let fieldNameString = dictionary.parseString(forKey: Constants.Key.FieldName) else { return nil }
		guard let fieldValueString = dictionary.parseString(forKey: Constants.Key.FieldVal) else { return nil }

		model.fieldName = fieldNameString
		model.fieldValue = fieldValueString

		return model.tap_asSelf()
	}

	/*!
	Initializes a new instance of PVAPIBusinessField with given parameters.

	- parameter name:  Field name.
	- parameter value: Field value, if nil, empty string will be used.

	- returns: New instance of PVAPIBusinessField.
	*/
	internal required init(name: String, value: String? = String.tap_empty) {

		super.init()

		fieldName = name
		fieldValue = value ?? String.tap_empty
	}

	public required init() { super.init() }
}
