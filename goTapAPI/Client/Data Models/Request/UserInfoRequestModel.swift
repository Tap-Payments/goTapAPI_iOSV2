//
//  UserInfoRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/6/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// User info request model.
internal class UserInfoRequestModel: goTapAPI.RequestModel {
	
	//MARK: - Public -
	//MARK: Properties
	
	/// User data.
	internal private(set) var userData: String?
	
	/// Input field.
	internal private(set) var inputFields: [goTapAPI.BusinessField]?
	
	internal override var serializedModel: AnyObject? {
		
		let serializedInputFields = goTapAPI.ParseHelper.serialize(array: inputFields)
		let emptyArray: [AnyObject] = []
		
		var result: [String: Any] = [:]
			
		result[goTapAPI.Constants.Key.UserData] = userData ?? NSNull()
		result[goTapAPI.Constants.Key.InputFields] = serializedInputFields ?? emptyArray
		
		return result as AnyObject
	}
	
	//MARK: Methods
	
	/**
	 Initializes data model with user data and input fields.
	 
	 - parameter userData:	User data.
	 - parameter inputFields: Input fields.
	 
	 - returns: TPAPIUserInfoRequestModel
	 */
	internal init(userData: String?, inputFields: [goTapAPI.BusinessField]?) {
		
		super.init()
		
		self.userData = userData
		self.inputFields = inputFields
	}
	
	public required init() { super.init() }
}