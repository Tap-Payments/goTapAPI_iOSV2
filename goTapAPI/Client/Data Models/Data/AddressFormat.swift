//
//  AddressFormat.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 2/24/17.
//  Copyright © 2017 Tap Payments. All rights reserved.
//

/// Address Format.
public class AddressFormat: DataModel {

	//MARK: - Public -
	//MARK: Properties
	
	/// Headers.
	public private(set) var headers: [AddressFormatHeader] = []
	
	/// Header details.
	public private(set) var details: [AddressFormatDetail] = []
	
	//MARK: - Internal -
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? AddressFormat else { return nil }
		
		let headerParsingClosure: (AnyObject) -> AddressFormatHeader? = { object in
		
			return AddressFormatHeader().dataModelWith(serializedObject: object)
		}
		let emptyHeaders: [AddressFormatHeader] = []
		let parsedHeaders = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.AddressHdrs), usingClosure: headerParsingClosure) ?? emptyHeaders
		
		let detailParsingClosure: (AnyObject) -> AddressFormatDetail? = { object in
		
			return AddressFormatDetail().dataModelWith(serializedObject: object)
		}
		let emptyDetails: [AddressFormatDetail] = []
		let parsedDetails = ParseHelper.parse(array: dictionary.parseArray(forKey: Constants.Key.AddressHdrDtls), usingClosure: detailParsingClosure) ?? emptyDetails
		
		model.headers = parsedHeaders
		model.details = parsedDetails
		
		return model.tap_asSelf()
	}
	
	public required init() { super.init() }
}
