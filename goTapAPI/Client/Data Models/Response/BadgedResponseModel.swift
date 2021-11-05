//
//  BadgedResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/8/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Delete list response model.
public class BadgedResponseModel: goTapAPI.ResponseModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Application badge.
	public private(set) var badge: Int64 = 0
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
	 
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.BadgedResponseModel else { return nil }
		
		model.badge = dictionary.parseInteger(forKey: goTapAPI.Constants.Key.Badge) ?? 0
		
		return model.tap_asSelf()
	}
}
