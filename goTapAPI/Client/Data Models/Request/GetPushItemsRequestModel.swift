//
//  GetPushItemsRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for getting push items.
internal class GetPushItemsRequestModel: goTapAPI.RequestModel {

	//MARK: - Public -
	//MARK: Properties

	/// Session ID.
	internal private(set) var sessionID: String = String.tap_empty

	/// Defines if action button was pressed.
	internal private(set) var actionButtonWasPressed: Swift.Bool = false

	internal override var serializedModel: AnyObject? {

		let result: [String: Any] = [

			goTapAPI.Constants.Key.sessID: sessionID,
			goTapAPI.Constants.Key.Action: actionButtonWasPressed ? goTapAPI.Constants.Value.PAY : goTapAPI.Constants.Value.VIEW
		]

		return result as AnyObject
	}

	//MARK: Methods

	/**
	 Initializes data model with given sessionID and actionButtonWasPressed fields.

	 - parameter sessionID:              Session ID.
	 - parameter actionButtonWasPressed: Defines if action button was pressed.

	 - returns: TPAPIGetPushItemsRequestModel
	 */
	internal init(sessionID: String, actionButtonWasPressed: Swift.Bool) {

		super.init()

		self.sessionID = sessionID
		self.actionButtonWasPressed = actionButtonWasPressed
	}

	public required init() { super.init() }
}
