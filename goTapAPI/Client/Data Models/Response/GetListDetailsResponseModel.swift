//
//  GetListDetailsResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Get list details response model.
public class GetListDetailsResponseModel: goTapAPI.BadgedResponseModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Businesses.
	public private(set) var businesses: [goTapAPI.BusinessItem] = []
	
	/// Detailed home items.
	public private(set) var detailedHomeItems: [goTapAPI.DetailedHomeItem] = []
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
	 
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.GetListDetailsResponseModel else { return nil }
		
		let businessParsingClosure: (AnyObject) -> goTapAPI.BusinessItem? = { object in
		
			return goTapAPI.BusinessItem().dataModelWith(serializedObject: object)
		}
		let emptyBusinesses: [goTapAPI.BusinessItem] = []
		let parsedBusinesses = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.Businesses), usingClosure: businessParsingClosure)
		
		let itemParsingClosure: (AnyObject) -> goTapAPI.DetailedHomeItem? = { object in
		
			return goTapAPI.DetailedHomeItem().dataModelWith(serializedObject: object)
		}
		let emptyItems: [goTapAPI.DetailedHomeItem] = []
		let parsedItems = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.HomeItemDtls), usingClosure: itemParsingClosure)
		
		model.businesses = parsedBusinesses == nil ? emptyBusinesses : parsedBusinesses!
		model.detailedHomeItems = parsedItems == nil ? emptyItems : parsedItems!
		
		return model.tap_asSelf()
	}
}
