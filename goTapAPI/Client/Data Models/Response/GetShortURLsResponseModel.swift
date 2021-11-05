//
//  GetShortURLsResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/1/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Response model for GetShortURL request.
public class GetShortURLsResponseModel: goTapAPI.ResponseModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Short URLs.
	public private(set) var shortURLs: [goTapAPI.ShortURLResponse] = []
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
	 
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.GetShortURLsResponseModel else { return nil }
		
		let emptyURLs: [goTapAPI.ShortURLResponse] = []
		let shortURLParsingClosure: (AnyObject) -> goTapAPI.ShortURLResponse? = { object in
		
			return goTapAPI.ShortURLResponse().dataModelWith(serializedObject: object)
		}
		
		let parsedShortURLs = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.Shorturls), usingClosure: shortURLParsingClosure)
		model.shortURLs = parsedShortURLs == nil ? emptyURLs : parsedShortURLs!
		
		return model.tap_asSelf()
	}
}
