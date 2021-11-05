//
//  GetUpdatesRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for get updates request.
internal class GetUpdatesRequestModel: goTapAPI.RequestModel {

	//MARK: - Public -
	//MARK: Properties
	
	override var serializedModel: AnyObject? {
		
		let applicationData = goTapAPI.ApplicationData.sharedInstance
		
		let result: [String: Any] = [
		   
		   goTapAPI.Constants.Key.ReqFor: goTapAPI.Client.sharedInstance.dataSource!.deviceValue(),
		   goTapAPI.Constants.Key.DeviceName: applicationData.deviceName,
		   goTapAPI.Constants.Key.DeviceModel: applicationData.deviceModel,
		   goTapAPI.Constants.Key.LocalizedModel: applicationData.localizedDeviceModel,
		   goTapAPI.Constants.Key.SystemName: applicationData.systemName,
		   goTapAPI.Constants.Key.SystemVersion: applicationData.systemVersion,
		   goTapAPI.Constants.Key.UserInterfaceIdiom: applicationData.userInterfaceIdiom
		]
		
		return result as AnyObject
	}
	
	//MARK: Methods
	
	public required init() { super.init() }
}