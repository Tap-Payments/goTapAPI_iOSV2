//
//  ItemViewedUpdateRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for item viewed update request.
internal class ItemViewedUpdateRequestModel: goTapAPI.IDsRequestModel {

	//MARK: - Public -
	//MARK: Properties
	
	internal override var serializedModel: AnyObject? {
		
		guard var result = super.serializedModel as? [String: Any] else { return nil }
		result[goTapAPI.Constants.Key.LstOption] = goTapAPI.Constants.Value.ITM_VIW;
		
		return result as AnyObject
	}
}