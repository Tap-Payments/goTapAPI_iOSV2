//
//  PermissionsRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for setting permissions.
internal class PermissionsRequestModel: RequestModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Permissions.
	internal private(set) var permissions: Permissions = Permissions()
	
	internal override var serializedModel: AnyObject? {
		
		return permissions.serializedModel
	}
	
	//MARK: Methods
	
	/**
	 Initializes data model with permissions.
	 
	 - parameter permissions: Permissions.
	 
	 - returns: TPAPISetPermissionsRequestModel
	 */
	internal init(permissions: Permissions) {
		
		super.init()
		self.permissions = permissions
	}
	
	public required init() { super.init() }
}
