//
//  IDsRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for delete list request.
internal class IDsRequestModel: RequestModel {

	//MARK: - Public -
	//MARK: Properties

	internal var serializesToArray: Swift.Bool = false

	/// IDs of the items that should be deleted.
	internal private(set) var ids: [ListID] = []

	internal override var serializedModel: AnyObject? {

		if serializesToArray {

			return arraySerializedModel
		}

		guard var result = super.serializedModel as? [String: Any] else { return nil }
		result[Constants.Key.LstOption] = self.listOption as AnyObject

		result.setNullable(value: arraySerializedModel, forKey: Constants.Key.IDS)

		return result as AnyObject
	}

	//MARK: Methods

	internal required init(IDs: [ListID]) {

		super.init()
		self.ids = IDs
	}

	internal required convenience init() { self.init(IDs:[]) }

	//MARK: - Private -
	//MARK: Properties

	private var arraySerializedModel: AnyObject? {

		return ParseHelper.serialize(array: self.ids) as AnyObject?
	}

	private var listOption: String {

		guard ids.count > 0 else { return Constants.Value.ALL }

		for listID in ids {

			if StringExtension.equal(string1: listID.type.stringRepresentation, string2: Constants.Value.STATIC) {

				return Constants.Value.ORD_DTL
			}
		}

		return ids.count == 1 ? Constants.Value.REGID : Constants.Value.ALL
	}
}
