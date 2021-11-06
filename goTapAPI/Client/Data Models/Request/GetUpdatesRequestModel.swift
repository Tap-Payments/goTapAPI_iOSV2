//
//  GetUpdatesRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for get updates request.
internal class GetUpdatesRequestModel: RequestModel {

	//MARK: - Public -
	//MARK: Properties
	
	override var serializedModel: AnyObject? {
		
		let applicationData = ApplicationData.sharedInstance
		
		let result: [String: Any] = [
		   
		   Constants.Key.ReqFor: Client.sharedInstance.dataSource!.deviceValue(),
		   Constants.Key.DeviceName: applicationData.deviceName,
		   Constants.Key.DeviceModel: applicationData.deviceModel,
		   Constants.Key.LocalizedModel: applicationData.localizedDeviceModel,
		   Constants.Key.SystemName: applicationData.systemName,
		   Constants.Key.SystemVersion: applicationData.systemVersion,
		   Constants.Key.UserInterfaceIdiom: applicationData.userInterfaceIdiom
		]
		
		return result as AnyObject
	}
	
	//MARK: Methods
	
	public required init() { super.init() }
}
