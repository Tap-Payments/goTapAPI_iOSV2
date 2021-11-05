//
//  ApplicationRegisterRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Application register request model.
internal class ApplicationRegisterRequestModel: goTapAPI.RequestModel {

	//MARK: - Public -
	//MARK: Properties

	internal override var serializedModel: AnyObject? {

		guard var result = super.serializedModel as? [String: Any] else { return nil }

		result[goTapAPI.Constants.Key.AppData] = goTapAPI.ApplicationData.sharedInstance.serializedModel ?? NSNull()

		return result as AnyObject
	}
}