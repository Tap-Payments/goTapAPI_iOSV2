//
//  QuickAddListRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Quick add list request model.
internal class QuickAddListRequestModel: goTapAPI.RequestModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Input data.
	private(set) var inputData: goTapAPI.QuickAddListInputData = goTapAPI.QuickAddListInputData.Mobile
	
	/// Business fields.
	private(set) var businessFields: [goTapAPI.BusinessField] = []
	
	override var serializedModel: AnyObject? {
		
		guard var result = super.serializedModel as? [String: Any] else { return nil }
		
		let emptyArray: [AnyObject] = []
		
		result[goTapAPI.Constants.Key.InputData] = inputData.stringRepresentation
		result[goTapAPI.Constants.Key.BizFields] = goTapAPI.ParseHelper.serialize(array: businessFields) ?? emptyArray
		
		return result as AnyObject
	}
	
	//MARK: Methods
	
	/**
	 Initializes data model with input data and business fields.
	 
	 - parameter inputData:	  Input data.
	 - parameter businessFields: Business fields.
	 
	 - returns: TPAPIQuickAddListRequestModel
	 */
	init(inputData: goTapAPI.QuickAddListInputData, businessFields: [goTapAPI.BusinessField]) {
		
		super.init()
		
		self.inputData = inputData
		self.businessFields = businessFields
	}
	
	public required init() { super.init() }
}