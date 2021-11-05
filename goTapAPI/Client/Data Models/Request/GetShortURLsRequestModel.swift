//
//  GetShortURLsRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for Get Short URL request.
internal class GetShortURLsRequestModel: goTapAPI.RequestModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Requests to get short URLs for.
	internal private(set) var requests: [goTapAPI.ShortURLRequest] = []
	
	internal override var serializedModel: AnyObject? {
		
		return goTapAPI.ParseHelper.serialize(array: requests) as AnyObject
	}
	
	//MARK: Methods
	
	/**
	 Initializes data model with requests.
	 
	 - parameter requests: Requests.
	 
	 - returns: TPAPIGetShortURLRequestModel
	 */
	internal init(requests: [goTapAPI.ShortURLRequest]) {
		
		super.init()
		self.requests = requests
	}
	
	public required init() { super.init() }
}