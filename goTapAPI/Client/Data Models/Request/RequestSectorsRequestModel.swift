//
//  RequestSectorsRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for request sectors request.
internal class RequestSectorsRequestModel: goTapAPI.RequestModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Sectors.
	internal private(set) var sectors: [goTapAPI.Sector] = []
	
	internal override var serializedModel: AnyObject? {
		
		return goTapAPI.ParseHelper.serialize(array: sectors) as AnyObject
	}
	
	//MARK: Methods
	
	/**
	 Initializes data model with sectors.
	 
	 - parameter sectors: Sectors.
	 
	 - returns: TPAPIRequestSectorRequestModel
	 */
	internal init(sectors: [goTapAPI.Sector]) {
		
		super.init()
		
		self.sectors = sectors
	}
	
	public required init() { super.init() }
}