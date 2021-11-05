//
//  ApplicationRegisterResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Response model for application registration request.
public class ApplicationRegisterResponseModel: goTapAPI.ResponseModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// App ID.
	public private(set) var appID: String?
	
	/// Device ID.
	public private(set) var deviceID: String?
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
	 
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.ApplicationRegisterResponseModel else { return nil }
		
		let parsedAppID = dictionary.parseString(forKey: goTapAPI.Constants.Key.APPID)
		goTapAPI.ApplicationData.sharedInstance.storeApplicationID(parsedAppID)
		
		let parsedDeviceID = dictionary.parseString(forKey: goTapAPI.Constants.Key.DeviceID)
		goTapAPI.ApplicationData.sharedInstance.storeDeviceID(parsedDeviceID)
		
		model.appID = parsedAppID
		model.deviceID = parsedDeviceID
		
		return model.tap_asSelf()
	}
}
