//
//  ScheduleItemRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 28/09/17.
//  Copyright © 2017 Tap Payments. All rights reserved.
//

/// Request model to schedule item.
internal class ScheduleItemRequestModel: goTapAPI.RequestModel {

	// MARK: - Internal -
	// MARK: Properties

	/// Item's list ID to schedule the amount.
	internal private(set) var listID: goTapAPI.ListID?

	/// Input fields ( schedule options ).
	internal private(set) var inputFields: [goTapAPI.BusinessField] = []

	internal override var serializedModel: AnyObject? {

		let serializedInputFields = goTapAPI.ParseHelper.serialize(array: self.inputFields)
		let emptyArray: [AnyObject] = []

		var result: [String: Any] = [:]

		result[goTapAPI.Constants.Key.LstID] = self.listID?.serializedModel ?? NSNull()
		result[goTapAPI.Constants.Key.InputFields] = serializedInputFields ?? emptyArray

		return result as AnyObject
	}

	// MARK: Methods

	internal init(listID: goTapAPI.ListID, inputFields: [goTapAPI.BusinessField]) {

		self.listID = listID
		self.inputFields = inputFields
	}

	public required init() { super.init() }
}