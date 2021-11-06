//
//  RequestApplicationRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for application request operation.
internal class RequestApplicationRequestModel: RequestModel {
	
	//MARK: - Public -
	//MARK: Properties
	
	override var serializedModel: AnyObject? {
		
		guard var result = super.serializedModel as? [String: Any] else { return nil }
		
		result[Constants.Key.AppData] = ApplicationData.sharedInstance.serializedModel ?? NSNull()
		
		return result as AnyObject
	}
}
