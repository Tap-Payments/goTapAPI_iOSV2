//
//  AddressFormat.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/24/17.
//  Copyright © 2017 Tap Payments. All rights reserved.
//

/// Address Format.
public class AddressFormat: goTapAPI.DataModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Headers.
	public private(set) var headers: [goTapAPI.AddressFormatHeader] = []
	
	/// Header details.
	public private(set) var details: [goTapAPI.AddressFormatDetail] = []
	
	//MARK: - Internal -
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? goTapAPI.AddressFormat else { return nil }
		
		let headerParsingClosure: (AnyObject) -> goTapAPI.AddressFormatHeader? = { object in
		
			return goTapAPI.AddressFormatHeader().dataModelWith(serializedObject: object)
		}
		let emptyHeaders: [goTapAPI.AddressFormatHeader] = []
		let parsedHeaders = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.AddressHdrs), usingClosure: headerParsingClosure) ?? emptyHeaders
		
		let detailParsingClosure: (AnyObject) -> goTapAPI.AddressFormatDetail? = { object in
		
			return goTapAPI.AddressFormatDetail().dataModelWith(serializedObject: object)
		}
		let emptyDetails: [goTapAPI.AddressFormatDetail] = []
		let parsedDetails = goTapAPI.ParseHelper.parse(array: dictionary.parseArray(forKey: goTapAPI.Constants.Key.AddressHdrDtls), usingClosure: detailParsingClosure) ?? emptyDetails
		
		model.headers = parsedHeaders
		model.details = parsedDetails
		
		return model.tap_asSelf()
	}
	
	public required init() { super.init() }
}
