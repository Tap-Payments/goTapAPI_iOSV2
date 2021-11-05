//
//  Sector.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 7/21/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Sector data model.
public class Sector: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// Sector ID.
	public private(set) var identifier: Int64 = 0

	/// Sector name.
	public private(set) var name: String = String.tap_empty

	internal override var serializedModel: AnyObject? {

		let result: [String: Any] = [

			goTapAPI.Constants.Key.ID: identifier,
			goTapAPI.Constants.Key.Name: name
		]

		return result as AnyObject
	}

	//MARK: Methods

	/**
	 Initializes sector with identifier and name.

	 - parameter identifier: Identifier.
	 - parameter name:       Sector name.

	 - returns: New instance of TPAPISector
	 */
	internal init(identifier: Int64, name: String!) {

		super.init()

		self.identifier = identifier
		self.name = name
	}

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.Sector else { return nil }

		guard let parsedIdentifierNumber = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.ID) else { return nil }
		guard let parsedName = dictionary.parseString(forKey: goTapAPI.Constants.Key.Name) else { return nil }

		model.identifier = parsedIdentifierNumber
		model.name = parsedName

		return model.tap_asSelf()
	}

	//required init?(coder aDecoder: NSCoder) {

		//super.init()

		//identifier = aDecoder.decodeInteger(forKey: PITAPIIDKey)
		//name = aDecoder.decodeObject(forKey: PITAPINameKey) as? String

	//}

	//func encodeWithCoder(aCoder: NSCoder) {

		//aCoder.encodeInteger(Int(identifier), forKey: PITAPIIDKey)
		//aCoder.encodeObject(name, forKey: PITAPINameKey)
	//}

	public required init() { super.init() }
}
