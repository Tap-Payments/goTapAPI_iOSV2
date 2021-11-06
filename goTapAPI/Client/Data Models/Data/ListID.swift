//
//  ListID.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// List ID data model.
public class ListID: DataModel {

	//MARK: - Public -
	//MARK: Properties

	/// ID number.
	public private(set) var number: Int64 = 0

	/// ID type.
	public private(set) var type: ItemType = ItemType.Static

	internal override var serializedModel: AnyObject? {

		var result: [String: Any] = [

			Constants.Key.IDNmbr: number
		]

		result[Constants.Key.IDType] = self.type.stringRepresentation

		return result as AnyObject
	}

	//MARK: Methods

	public required init() { super.init() }

	internal init(number: Int64, type: ItemType) {

		super.init()

		self.number = number
		self.type = type
	}

	internal override func dataModelWith(serializedObject: Any?) -> Self? {

		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }

		guard let numberInt = dictionary.parseInteger(forKey: Constants.Key.IDNmbr) else { return nil }
		guard let typeString = dictionary.parseString(forKey: Constants.Key.IDType) else { return nil }

		self.number = numberInt
		self.type = ItemType.with(stringValue: typeString)

		return self
	}
}

extension ListID: ListIDRepresentable {

	public var listID: ListID {

		return self
	}
}
