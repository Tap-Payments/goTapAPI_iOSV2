//
//  ScheduleItemRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 28/09/17.
//  Copyright © 2017 Tap Payments. All rights reserved.
//

/// Request model to schedule item.
internal class ScheduleItemRequestModel: RequestModel {

	// MARK: - Internal -
	// MARK: Properties

	/// Item's list ID to schedule the amount.
	internal private(set) var listID: ListID?

	/// Input fields ( schedule options ).
	internal private(set) var inputFields: [BusinessField] = []

	internal override var serializedModel: AnyObject? {

		let serializedInputFields = ParseHelper.serialize(array: self.inputFields)
		let emptyArray: [AnyObject] = []

		var result: [String: Any] = [:]

		result[Constants.Key.LstID] = self.listID?.serializedModel ?? NSNull()
		result[Constants.Key.InputFields] = serializedInputFields ?? emptyArray

		return result as AnyObject
	}

	// MARK: Methods

	internal init(listID: ListID, inputFields: [BusinessField]) {

		self.listID = listID
		self.inputFields = inputFields
	}

	public required init() { super.init() }
}
