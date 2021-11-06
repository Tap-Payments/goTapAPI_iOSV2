//
//  UserInfoRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/6/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// User info request model.
internal class UserInfoRequestModel: RequestModel {
	
	//MARK: - Public -
	//MARK: Properties
	
	/// User data.
	internal private(set) var userData: String?
	
	/// Input field.
	internal private(set) var inputFields: [BusinessField]?
	
	internal override var serializedModel: AnyObject? {
		
		let serializedInputFields = ParseHelper.serialize(array: inputFields)
		let emptyArray: [AnyObject] = []
		
		var result: [String: Any] = [:]
			
		result[Constants.Key.UserData] = userData ?? NSNull()
		result[Constants.Key.InputFields] = serializedInputFields ?? emptyArray
		
		return result as AnyObject
	}
	
	//MARK: Methods
	
	/**
	 Initializes data model with user data and input fields.
	 
	 - parameter userData:	User data.
	 - parameter inputFields: Input fields.
	 
	 - returns: TPAPIUserInfoRequestModel
	 */
	internal init(userData: String?, inputFields: [BusinessField]?) {
		
		super.init()
		
		self.userData = userData
		self.inputFields = inputFields
	}
	
	public required init() { super.init() }
}
