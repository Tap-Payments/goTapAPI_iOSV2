//
//  GetListDetailsResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/11/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

/// Get list details response model.
public class GetListDetailsResponseModel: BadgedResponseModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Businesses.
	public private(set) var businesses: [BusinessItem] = []
	
	/// Detailed home items.
	public private(set) var detailedHomeItems: [DetailedHomeItem] = []
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
	 
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? GetListDetailsResponseModel else { return nil }
		
		let businessParsingClosure: (AnyObject) -> BusinessItem? = { object in
		
			return BusinessItem().dataModelWith(serializedObject: object)
		}
		let emptyBusinesses: [BusinessItem] = []
		let parsedBusinesses = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.Businesses), usingClosure: businessParsingClosure)
		
		let itemParsingClosure: (AnyObject) -> DetailedHomeItem? = { object in
		
			return DetailedHomeItem().dataModelWith(serializedObject: object)
		}
		let emptyItems: [DetailedHomeItem] = []
		let parsedItems = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.HomeItemDtls), usingClosure: itemParsingClosure)
		
		model.businesses = parsedBusinesses == nil ? emptyBusinesses : parsedBusinesses!
		model.detailedHomeItems = parsedItems == nil ? emptyItems : parsedItems!
		
		return model.tap_asSelf()
	}
}
