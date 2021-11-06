//
//  ScheduleItemDetailsRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 28/09/17.
//  Copyright © 2017 Tap Payments. All rights reserved.
//

/// Request model to schedule item.
internal class ScheduleItemDetailsRequestModel: RequestModel {

	// MARK: - Internal -
	// MARK: Properties

	/// Item's list ID to schedule the amount.
	internal private(set) var item: ChangedDetailsHomeItem?

	/// Input fields ( schedule options ).
	internal private(set) var inputFields: [BusinessField] = []

	internal override var serializedModel: AnyObject? {

		let serializedInputFields = ParseHelper.serialize(array: self.inputFields)
		let emptyArray: [AnyObject] = []

		var result: [String: Any] = [:]

		result[Constants.Key.Item] = self.item?.serializedModel ?? NSNull()
		result[Constants.Key.InputFields] = serializedInputFields ?? emptyArray

		return result as AnyObject
	}

	// MARK: Methods

	internal init(item: ChangedDetailsHomeItem, inputFields: [BusinessField]) {

		self.item = item
		self.inputFields = inputFields
	}

	public required init() { super.init() }
}
