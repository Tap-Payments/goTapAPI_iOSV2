//
//  QuickAddListRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Quick add list request model.
internal class QuickAddListRequestModel: RequestModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Input data.
	private(set) var inputData: QuickAddListInputData = QuickAddListInputData.Mobile
	
	/// Business fields.
	private(set) var businessFields: [BusinessField] = []
	
	override var serializedModel: AnyObject? {
		
		guard var result = super.serializedModel as? [String: Any] else { return nil }
		
		let emptyArray: [AnyObject] = []
		
		result[Constants.Key.InputData] = inputData.stringRepresentation
		result[Constants.Key.BizFields] = ParseHelper.serialize(array: businessFields) ?? emptyArray
		
		return result as AnyObject
	}
	
	//MARK: Methods
	
	/**
	 Initializes data model with input data and business fields.
	 
	 - parameter inputData:	  Input data.
	 - parameter businessFields: Business fields.
	 
	 - returns: TPAPIQuickAddListRequestModel
	 */
	init(inputData: QuickAddListInputData, businessFields: [BusinessField]) {
		
		super.init()
		
		self.inputData = inputData
		self.businessFields = businessFields
	}
	
	public required init() { super.init() }
}
