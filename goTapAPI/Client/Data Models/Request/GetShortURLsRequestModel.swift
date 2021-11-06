//
//  GetShortURLsRequestModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/10/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Request model for Get Short URL request.
internal class GetShortURLsRequestModel: RequestModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Requests to get short URLs for.
	internal private(set) var requests: [ShortURLRequest] = []
	
	internal override var serializedModel: AnyObject? {
		
		return ParseHelper.serialize(array: requests) as AnyObject
	}
	
	//MARK: Methods
	
	/**
	 Initializes data model with requests.
	 
	 - parameter requests: Requests.
	 
	 - returns: TPAPIGetShortURLRequestModel
	 */
	internal init(requests: [ShortURLRequest]) {
		
		super.init()
		self.requests = requests
	}
	
	public required init() { super.init() }
}
