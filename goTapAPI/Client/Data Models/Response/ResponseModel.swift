//
//  ResponseModel.swift
//  goTapAPI
//
//  Created by Dennis Pashkov on 8/13/16.
//  Copyright © 2016 Tap Payments. All rights reserved.
//

public protocol ResponseHolder {
	
	var response: Response? { get }
}

/// Base response data model.
public class ResponseModel: DataModel, ResponseHolder {

	//MARK: - Public -
	//MARK: Properties
	
	/// Response.
	public private(set) var response: Response?
	
	//MARK: Methods
	
	internal override func dataModelWith(serializedObject: Any?) -> Self? {
		
		guard let dictionary = serializedObject as? [String: AnyObject] else { return nil }
		guard let model = super.dataModelWith(serializedObject: serializedObject) as? ResponseModel else { return nil }
		
		if let responseDict = dictionary.parseDictionary(forKey: Constants.Key.Response) {
		
			//writeLn("response dictionary: \(responseDict)")
			if let parsedResponse = Response.dataModelWith(responseDict as AnyObject) {
			
				model.response = parsedResponse
			}
		}
		else {
		 
			//writeLn("response dictionary is nil")
		}
		
		return model.tap_asSelf()
	}
}
