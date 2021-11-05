//
//  ResendCodeRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model to resend code.
internal class ResendCodeRequestModel: goTapAPI.RequestModel {

	//MARK: - Public -
	//MARK: Properties
	
	internal override var serializedModel: AnyObject? {
		
		guard var result = super.serializedModel as? [String: Any] else { return nil }
		
		result[goTapAPI.Constants.Key.AppData] = goTapAPI.ApplicationData.sharedInstance.serializedModel ?? NSNull()
		
		return result as AnyObject
	}
}