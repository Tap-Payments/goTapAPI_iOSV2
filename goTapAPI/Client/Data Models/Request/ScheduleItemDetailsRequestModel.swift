//
//  ScheduleItemDetailsRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 28/09/17.
//  Copyright © 2017 Tap Payments. All rights reserved.
//

/// Request model to schedule item.
internal class ScheduleItemDetailsRequestModel: goTapAPI.RequestModel {

	// MARK: - Internal -
	// MARK: Properties

	/// Item's list ID to schedule the amount.
	internal private(set) var item: goTapAPI.ChangedDetailsHomeItem?

	/// Input fields ( schedule options ).
	internal private(set) var inputFields: [goTapAPI.BusinessField] = []

	internal override var serializedModel: AnyObject? {

		let serializedInputFields = goTapAPI.ParseHelper.serialize(array: self.inputFields)
		let emptyArray: [AnyObject] = []

		var result: [String: Any] = [:]

		result[goTapAPI.Constants.Key.Item] = self.item?.serializedModel ?? NSNull()
		result[goTapAPI.Constants.Key.InputFields] = serializedInputFields ?? emptyArray

		return result as AnyObject
	}

	// MARK: Methods

	internal init(item: goTapAPI.ChangedDetailsHomeItem, inputFields: [goTapAPI.BusinessField]) {

		self.item = item
		self.inputFields = inputFields
	}

	public required init() { super.init() }
}